unit preferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons, ImgList, ComCtrls,
  ExtCtrls, ToolWin;

type
  TfrmPreferences = class(TForm)
    GroupBox1: TGroupBox;
    leLogId: TValueListEditor;
    ToolBar1: TToolBar;
    btnAdd: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPreferences: TfrmPreferences;

implementation
uses
  IniFiles, AddLogAliace, main;
{$R *.dfm}

procedure TfrmPreferences.FormCreate(Sender: TObject);
var
  ini : TMemIniFile;
begin
  ini := TMemIniFile.Create('api.ini');
  try
    ini.ReadSectionValues('LOGID', leLOGid.Strings);
  finally
    ini.Free();
  end;
end;

procedure TfrmPreferences.btnAddClick(Sender: TObject);
var
  ini : TMemIniFile;
begin
  with frmAddNewLogAliace do
    if ShowModal() = mrOk then begin
      leLOGid.Strings.Clear();
      ini := TMemIniFile.Create('api.ini');
      try
        ini.WriteString('LOGID', edKey.Text, edValue.Text);
        ini.ReadSectionValues('LOGID', leLOGid.Strings);
      finally
        ini.Free();
      end;
    end;
end;

end.
