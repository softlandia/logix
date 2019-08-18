unit FExportToRms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Utils, cLas, Placement, ImgList;

type
  TfrmExportToRms = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    lvLogs: TListView;
    lvParams: TListView;
    FormStorage: TFormStorage;
    btnAddTrajectory: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    chkRecalcHoleTrajectory: TCheckBox;
    edFileName: TEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddTrajectoryClick(Sender: TObject);
    procedure lvLogsDblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    lf : TLasFile;
    function EditLOGparams(var li : TListItem) : integer;
  public
    function Init(const las : TLasFile) : integer;
    function Finish(var las : TLasFile; var filename : string) : integer;
  end;

implementation
uses
  EditLOGid, main;
{$R *.dfm}

function TfrmExportToRms.Init(const las : TLasFile) : integer;
var
  i     : integer;
  li    : TListItem;
begin
  result := _ERROR_;
  if not Assigned(las) then
    exit;
  lf := las;
  lvLogs.Items.Clear();
  for i := 0 to las.logs.count-1 do begin
    li := lvLOGs.Items.Add();
    li.Caption := Trim(las.logs[i]);
    li.SubItems.Add(Trim(las.logs.GetUnit(i)));
    li.SubItems.Add(FloatToStr(las.logs.y(i).min));
    li.SubItems.Add(FloatToStr(las.logs.y(i).max));
    li.Checked := las.Logs.LOG(i).Selected;
  end;
  lvParams.Items.Clear();
  for i := 0 to las.Params.Count-1 do begin
    li := lvParams.Items.Add();
    li.Caption := Trim(las.Params[i]);                 //name
    li.SubItems.Add(Trim(las.Params.GetValue(i)));     //value
    li.SubItems.Add(Trim(las.Params.GetUnit(i)));      //unit
  end;
  result := _OK_;
end;

function TfrmExportToRms.Finish(var las : TLasFile; var filename : string) : integer;
var
  i : integer;
begin
  result := _ERROR_;
  for i := 0 to lvLogs.Items.Count-1 do begin
    las.Logs.Log(i).Selected := lvLOGs.Items[i].Checked;
  end;
  for i := 0 to lvParams.Items.Count-1 do begin
    las.Params.GetItem(i).Checked := lvParams.Items[i].Checked;
  end;
  las.RecalcHoleTrajectory := chkRecalcHoleTrajectory.Checked;
  filename := edFileName.Text;
  if length(filename) <= 0 then
    exit;
  result := _OK_;
end;

procedure TfrmExportToRms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmExportToRms.btnAddTrajectoryClick(Sender: TObject);
begin
  lf.AddTrajectory('EAST', 'NORTH', 'TVD', 0, 0, lf.Header.asFloat('RKB'));
  Init(lf);  
end;

procedure TfrmExportToRms.lvLogsDblClick(Sender: TObject);
var
  li : TListItem;
begin
  li := lvLOGs.ItemFocused;
  if EditLOGparams(li) = _OK_ then
    StatusBar1.Panels[0].Text := 'info: edit log successful...'
  else
    StatusBar1.Panels[0].Text := 'info: edit log is fault...';
end;

function TfrmExportToRms.EditLOGparams(var li : TListItem) : integer;
begin
  try
    with frmEditLOGid do begin
      edLOGid.Text := li.Caption;
      edUnit.Text  := li.SubItems[0];
      edMin.Text   := PutDecimalSeparator(li.SubItems[1]);
      edMax.Text   := PutDecimalSeparator(li.SubItems[2]);
      if ShowModal() = mrOK then begin
        li.Caption     := edLOGid.Text;
        li.SubItems[0] := edUnit.Text;
        li.SubItems[1] := edMin.Text;
        li.SubItems[2] := edMax.Text;
        result := _OK_;
      end
      else
        result := _ERROR_;
    end;
  except
    result := _ERROR_;
  end;
end;

procedure TfrmExportToRms.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute() then
    edFileName.Text := OpenDialog1.FileName;
end;

end.
