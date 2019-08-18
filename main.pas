unit main;
{$DEFINE Debug}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ToolWin, ComCtrls, Menus, Common, ImgList,
  JvFormPlacement, JvComponentBase, JvAppStorage, JvAppIniStorage, Grids,
  ValEdit, System.ImageList(*, System.ImageList*);

type
  TfrmMain = class(TForm)
    ButtonImages: TImageList;
    ToolBar1: TToolBar;
    btnNewLAS: TToolButton;
    btnBrowser: TToolButton;
    btnFillAPI: TToolButton;
    btnChangeLOGid: TToolButton;
    btnCreateHeaderList: TToolButton;
    tblPreferences: TToolButton;
    btnJounLas: TToolButton;
    btnHelp: TToolButton;
    btnAbout: TToolButton;
    JvAppIniFileStorage1: TJvAppIniFileStorage;
    JvFormStorage1: TJvFormStorage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    ///	<remarks>
    ///	  <para>
    ///	    Создание глобальных объектов:
    ///	  </para>
    ///	  <para>
    ///	    lf : TLASFile; - LAS file
    ///	  </para>
    ///	  <para>
    ///	    strlstFile : TStringList; - список файлов для обработки
    ///	  </para>
    ///	  <para>
    ///	    strlstAPI : TBiStrList.Create(); - список подстановок для мнемоник
    ///	  </para>
    ///	</remarks>
    procedure FormCreate(Sender: TObject);
    procedure btnFillAPIClick(Sender: TObject);
    procedure btnCreateHeaderListClick(Sender: TObject);
    procedure btnChangeLOGidClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure LOGidcode1Click(Sender: TObject);
    procedure LOGid1Click(Sender: TObject);
    procedure LASlist1Click(Sender: TObject);
    procedure btnBrowserClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnJounLasClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function  OpenFolder(const sPath : string) : integer;
  public
    function  ReadAPIlist() : integer;
    function  ReadLogIdList() : integer;
  end;

var
  frmMain: TfrmMain;
  level  : integer;

implementation

uses floatlist, Utils, clas, IniFiles, CreateLas,
     APIcode, LogList, Browser, AddLAS, ChangeLOGid, JoinLAS,
     BiStrList, Preferences, LOGRecList, AboutBox, ShellAPI;

{$R *.DFM}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lf := TLASFile.Create();
  strlstFile := TStringList.Create();
  strlstAPI  := TBiStrList.Create();

  SaveDecimalSeparator := SysUtils.FormatSettings.DecimalSeparator;
  if SaveDecimalSeparator = ',' then
    SysUtils.FormatSettings.DecimalSeparator := '.';

  Application.HelpFile := 'LOGIX.HLP';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  strlstFile.Free();
  strlstDir.Free();
  strlstAPI.Clear();
  strlstAPI.Free();
  lf.free();
  SysUtils.FormatSettings.DecimalSeparator := SaveDecimalSeparator;
end;

function  TfrmMain.ReadAPIlist() : integer;
begin
  strlstAPI.ReadIniFile(ExtractFilePath(ParamStr(0))+ 'api.ini','API');
  result := _OK_;
end;

function  TfrmMain.ReadLogIdList() : integer;
var
  ini : TMemIniFile;
//  i : integer;
begin
  ini := TMemIniFile.Create('api.ini');
  try
    ini.ReadSectionValues('LOGID', frmPreferences.leLOGid.Strings);
  finally
    ini.Free();
  end;
  result := _OK_;
end;

procedure TfrmMain.btnFillAPIClick(Sender: TObject);
begin
  frmAPIcode.ShowModal();
end;

procedure TfrmMain.btnCreateHeaderListClick(Sender: TObject);
begin
  frmLogList.ShowModal();
end;

procedure TfrmMain.btnChangeLOGidClick(Sender: TObject);
begin
  with TfrmChangeLogId.Create(Application) do
    Show();
end;

procedure TfrmMain.Close1Click(Sender: TObject);
begin
  Close();
end;

procedure TfrmMain.LOGidcode1Click(Sender: TObject);
begin
  btnChangeLOGidClick(Sender);
end;

procedure TfrmMain.LOGid1Click(Sender: TObject);
begin
  btnFillAPIClick(Sender);
end;

procedure TfrmMain.LASlist1Click(Sender: TObject);
begin
  btnCreateHeaderListClick(Sender);
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  frmAboutBox.ShowModal();
end;

procedure TfrmMain.btnBrowserClick(Sender: TObject);
begin
  with TfrmBrowser.Create(TComponent(sender)) do begin
    Show();
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    btnHelpClick(Sender);
end;

procedure TfrmMain.btnJounLasClick(Sender: TObject);
begin
  with TfrmJoinLAS.Create(Application) do begin
    Show();
  end;
end;

(* btnNewLAS on click event *)
procedure TfrmMain.ToolButton1Click(Sender: TObject);
var
  lasfile : TLASFile;
begin
  lasfile := TLASFile.Create();
  with TfrmCreateLAS.Create(Application) do begin
    las := lasfile;
    Show();
  end;
  lasfile.Free();
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Writeln(logfile, 'Start reading api.ini');
  //список параметра площади
  if ReadAPIlist() = _OK_ then
    Writeln(logfile, 'Succesfull reading API section')
  else
    Writeln(logfile, 'Faild reading API section');
  Writeln(logfile, 'Start reading logs.ini');
  //список мнемоник
  if ReadLogIdList() = _OK_ then
    Writeln(logfile, 'Succesfull reading LOGID section')
  else
    Writeln(logfile, 'Faild reading LOGID section');

  //параметры стандартных каротажей
  stdLOG := TLogParamList.Create();
  if stdLOG.ReadIniFile(AddBackSlash(ExtractFilePath(ParamStr(0))) + LOGS_PARAMETERS_FILENAME ) = _OK_ then
    Writeln(logfile, 'Succesful reading logs.ini')
  else
    Writeln(logfile, 'Faild reading logs.ini');

  btnBrowserClick(Sender);
end;

procedure TfrmMain.Preferences1Click(Sender: TObject);
begin
  frmPreferences.ShowModal();
end;

function TfrmMain.OpenFolder(const sPath : string) : integer;
var
  SEI : TShellExecuteInfo;
  zFileName  : array[0..255] of Char;
//  aPath: AnsiString;
begin
  result := _OK_;
  StrPCopy(zFileName, sPath);
  FillChar(SEI, SizeOf(SEI), 0);
  with SEI do begin
    cbSize := SizeOf(SEI);
    wnd := Application.Handle;
    fMask := SEE_MASK_INVOKEIDLIST + SEE_MASK_FLAG_NO_UI;
    lpFile := zFileName;
    nShow := SW_SHOW;
  end;
  try
    if Integer(ShellExecuteEx(@SEI)) = 0 then begin
      result := _ERROR_;
    end;
  except
  end;
end;

procedure TfrmMain.btnHelpClick(Sender: TObject);
begin
//  Application.HelpCommand(HELP_CONTENTS	,0);
  OpenFolder('C:\Progra~1\logix\LOGIX.HLP');
end;

end.
