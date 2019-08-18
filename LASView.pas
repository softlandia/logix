////////////////////////////////////////////////////////////////////////////////
//Ôנויל הכÿ ןנמסלמענא las פאיכא
//ver   1.0.1
//date  22.04.2001
//autor softland@zmail.ru
////////////////////////////////////////////////////////////////////////////////

unit LASView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, CLAS, Utils, ExtCtrls;

type
  TfraLASView = class(TFrame)
    lvLOGs    : TListView;
    lvHeader  : TListView;
    procedure FrameResize(Sender: TObject);
    procedure lvHeaderDblClick(Sender: TObject);
    procedure lvLOGsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    function  InitListView(const lf : TLasFile): integer;
    function  EditLASparams(var li : TListItem) : integer;
    function  EditLOGparams(var li : TListItem) : integer;
  end;

implementation

uses
  EditLOGid, EditLASParams;

{$R *.DFM}

function  TfraLASView.InitListView(const lf : TLasFile): integer;
var
  i     : integer;
  li    : TListItem;
begin
  lvHeader.Items.Clear();
  for i := 0 to lf.header.count-1 do begin
    li := lvHeader.Items.Add();
    li.Caption := lf.header.strings[i];
    li.SubItems.Add(lf.header.asString(li.Caption));
  end;
  lvLOGs.Items.Clear();
  for i := 0 to lf.logs.count-1 do begin
    li := lvLOGs.Items.Add();
    li.Caption := Trim(lf.logs[i]);
    li.SubItems.Add(Trim(lf.logs.GetUnit(i)));
    li.SubItems.Add(FloatToStr(lf.logs.y(i).min));
    li.SubItems.Add(FloatToStr(lf.logs.y(i).max));
  end;
  result := _OK_;
end;

procedure TfraLASView.FrameResize(Sender: TObject);
begin
  lvHeader.Height := self.ClientHeight div 2;
end;

procedure TfraLASView.lvHeaderDblClick(Sender: TObject);
var
  li : TListItem;
begin
  li := lvHeader.ItemFocused;
  EditLASparams( li );
end;

function  TfraLASView.EditLASparams( var li : TListItem ) : integer;
begin
  try
    with frmEditLASParams do begin
      edFieldName.Text  := li.Caption;
      edFieldValue.Text := li.SubItems[0];
      if ShowModal() = mrOK then begin
//        li.Caption     := edFieldName.Text;
        li.SubItems[0] := edFieldValue.Text;
        result := _OK_;
      end
      else
        result := _ERROR_;
    end;
  except
    result := _ERROR_;
  end;
end;

function  TfraLASView.EditLOGparams(var li : TListItem) : integer;
begin
  try
    with frmEditLOGid do begin
      edLOGid.Text := li.Caption;
      edUnit.Text  := li.SubItems[0];
      edMin.Text  := PutDecimalSeparator(li.SubItems[1]);
      edMax.Text  := PutDecimalSeparator(li.SubItems[2]);
      if ShowModal = mrOK then begin
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

procedure TfraLASView.lvLOGsDblClick(Sender: TObject);
var
  li : TListItem;
begin
  li := lvLOGs.ItemFocused;
  EditLOGparams( li );
end;

end.
