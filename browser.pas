////////////////////////////////////////////////////////////////////////////////
//Форма для просмотра las файлов
//ver   1.0.1
//date  11.04.2001
//autor softland@zmail.ru
////////////////////////////////////////////////////////////////////////////////
//ver   1.0.2
//date  22.04.2001
//using frame "fraLASView"
////////////////////////////////////////////////////////////////////////////////
unit browser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, CLAS, ToolWin, ExtCtrls, StdCtrls, Common, Utils,
  ImgList, LASView, Menus, ShellCtrls, Buttons, JvComponentBase,
  JvFormPlacement;

//{$DEFINE _CASTRATE_}

{$IFDEF _CASTRATE_}
const
  _TOP_1 : integer = 2;
  _TOP_2 : integer = 2;
{$ELSE}
{$ENDIF}

type
  TfrmBrowser = class(TForm)
    Panel1: TPanel;
    sbStatus: TStatusBar;
    ToolBar1: TToolBar;
    btnSaveLAS: TToolButton;
    Panel2: TPanel;
    pbProgress: TProgressBar;
    btnCancelRead: TToolButton;
    btnSaveAs: TToolButton;
    SaveDlg: TSaveDialog;
    btnViewChart: TToolButton;
    fraLASView: TfraLASView;
    pLOGsMenu: TPopupMenu;
    mnuReplaceValue: TMenuItem;
    mnuAverageValue: TMenuItem;
    Mirror1: TMenuItem;
    btnSheetView: TToolButton;
    Panel3: TPanel;
    cbShell: TShellComboBox;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    btnFolderUp: TSpeedButton;
    chkOemToAnsi: TCheckBox;
    JvFormStorage1: TJvFormStorage;
    Splitter1: TSplitter;
    lvFileBrowser: TShellListView;
    ShellTreeView: TShellTreeView;
    Splitter2: TSplitter;
    chkFiltrate: TCheckBox;
    ppmShellListView: TPopupMenu;
    Tiles1: TMenuItem;
    Icons1: TMenuItem;
    List1: TMenuItem;
    Details1: TMenuItem;
    ToolButton1: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelReadClick(Sender: TObject);
    procedure btnSaveLASClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvHeaderKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvLOGsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure flFilesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dlFoldersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbDriveKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbFileMaskKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnViewChartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Mirror1Click(Sender: TObject);
(* Call back functions *)
    function InitProgress(sender : TObject; i : integer) : integer;
    function DoProgress(sender : TObject; i : integer) : integer;
    procedure mnuReplaceValueClick(Sender: TObject);
    procedure btnSheetViewClick(Sender: TObject);
    procedure lvFileBrowser1Click(Sender: TObject);
    procedure btnFolderUpClick(Sender: TObject);
    procedure lvFileBrowserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkOemToAnsiClick(Sender: TObject);
    procedure chkFiltrateClick(Sender: TObject);
    procedure List1Click(Sender: TObject);
    procedure ShellTreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
  private
    las : TLASFile;
    CancelFlag : BOOL;
  protected
//    FolderBase : string;
    function ChangeFile() : integer;
  public
//    InitFolder : string;
    function LoadLASFile(const _filename : string) : integer;
    function GotoFolder(const FolderName : string) : integer;
    function GetCurrentPath() : string;
  end;

{var
  frmLASBrowser : TfrmBrowser;}

implementation
uses
  Main, LOGChart, Replace, ViewSheet, IniFiles;
{$R *.DFM}

const
  FORM_CAPTION = 'View LAS file: ';
  STATUS_MESSAGE_READ = 'Reading, data line count: %u';
  STATUS_MESSAGE_READED = 'Loaded points: %u';

function TfrmBrowser.GetCurrentPath() : string;
begin
  result := ShellTreeView.Path;
end;

function  TfrmBrowser.GotoFolder(const FolderName : string) : integer;
begin
  try
    ShellTreeView.Path := FolderName;
  except
    sbStatus.Panels[1].Text := 'Восстановить ' + FolderName + ' не удалось.';
    ShellTreeView.Path := 'c:\';
  end;
  result := _OK_;
end;

function TfrmBrowser.InitProgress(sender : TObject; i : integer) : integer;
begin
  pbProgress.max := i;
  pbProgress.Position := 0;
  sbStatus.Panels[0].Text := Format( STATUS_MESSAGE_READ, [i] );
  sbStatus.Update();
  Application.ProcessMessages();
  result := _OK_;
end;

function TfrmBrowser.DoProgress(sender : TObject; i : integer) : integer;
begin
  pbProgress.Position := pbProgress.Position + 1;
  Application.ProcessMessages();
  if CancelFlag then
    result := _ERROR_
  else
    result := _OK_;
end;

procedure TfrmBrowser.List1Click(Sender: TObject);
var
  mi : TMenuItem;
  path : string;
begin
  mi := (Sender as TMenuItem);
  mi.Checked := true;
  path := ShellTreeView.Path;
  lvFileBrowser.ViewStyle := TViewStyle(mi.Tag);
  ShellTreeView.Path := path;
end;

function  TfrmBrowser.LoadLASFile( const _filename : string ) : integer;
begin
  result := _ERROR_;
  if pos('LAS', UpperCase(ExtractFileExt(_filename))) = 0 then
    exit;
  with pbProgress do begin
      min := 0;
      max := 100;
      position := min;
  end;
  las.Clear;
  las.init_progress := InitProgress;
  las.do_progress := DoProgress;
  CancelFlag := FALSE;
  btnCancelRead.Enabled := TRUE;
  try
    if las.Open(_filename) = _ERROR_ then begin
      exit;
    end;
    //Проверка на достоверность считанных данных
    if las.DataValid() = _ERROR_ then
      exit;
    result := _OK_;
  finally
    btnCancelRead.Enabled := FALSE;
    //возвращаем прогресс бар в исходное состояние *)
    with pbProgress do begin
        min := 0;
        max := 100;
        position := min;
    end;
  end;
  //Заполнение визуальных компонентов данными LAS файла *)
  fraLASView.InitListView(las);
  self.Caption := FORM_CAPTION + las.FileName;
  sbStatus.Panels[0].Text := Format(STATUS_MESSAGE_READED,[las.logs.y(0).Count]);
end;

procedure TfrmBrowser.FormCreate(Sender: TObject);
begin
  las := TLASFile.Create();
  fraLASView.lvLOGs.Checkboxes := true;
  Caption := FORM_CAPTION;
  lvFileBrowser.FlatScrollBars := true;
end;

procedure TfrmBrowser.btnCancelReadClick(Sender: TObject);
begin
  CancelFlag := TRUE;
end;

procedure TfrmBrowser.btnSaveLASClick(Sender: TObject);
begin
  las.SaveParameters(fraLASView.lvHeader, fraLASView.lvLOGs);
  try
    las.WriteToLAS( las.FileName );
    //возвращаем прогресс бар в исходное состояние *)
    with pbProgress do begin
        min := 0;
        max := 100;
        position := min;
    end;
  except
    MessageDlg( Format('Error saving file: %-s',[las.filename]),
                mtError, [mbOK], 0 );
  end;
end;

procedure TfrmBrowser.btnSaveAsClick(Sender: TObject);
begin
  if SaveDlg.Execute then begin
    las.SaveParameters( fraLASView.lvHeader, fraLASView.lvLOGs );
    las.FileName := SaveDlg.FileName;
    try
      las.WriteToLAS( las.FileName );
    lvFileBrowser.Update();
    except
      if MessageDlg( Format('Error saving file: %-s',[las.filename]),
                     mtError,
                    [mbCancel,mbRetry], 0 ) = mrRetry then
        btnSaveAsClick(sender);
    end;
  end;
end;

procedure TfrmBrowser.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((ssCtrl in Shift) and (Key = 83)) or ( Key = VK_F2 ) then
    btnSaveLASClick(Sender);
  if ( Key = VK_F5 ) then
    lvFileBrowser.Update();
end;

procedure TfrmBrowser.lvHeaderKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.lvLOGsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.flFilesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.dlFoldersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.cbDriveKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.cbFileMaskKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmBrowser.btnViewChartClick(Sender: TObject);
var
  i : integer;
begin
  try
    for i := 0 to fraLASView.lvLOGs.Items.Count-1 do begin
      las.Logs.LOG(i).Selected := fraLASView.lvLOGs.Items[i].Checked;
    end;
  except
    MessageDlg('Error #0001: mismatch count of visible and internal log list',
               mtError, [mbCancel], 0);
  end;
  with TfrmLOGChart.Create(self) do begin
    if Init( self.las ) = _OK_ then
      Show()
    else
      if retcode = _ERR_NO_LOG_SELECT_ then
        Dialogs.MessageDlg( 'Select log...', mtWarning, [mbOK], 0 );
      if retcode = _ERR_INPUT_PARAMETERS_ then
        Dialogs.MessageDlg( 'LAS file are not valid...', mtError, [mbOK], 0 );
  end;
end;

procedure TfrmBrowser.FormShow(Sender: TObject);
var
  ini : TIniFile;
begin
  las.FlagOemToAnsi := chkOemToAnsi.Checked;
  try
    Utils.LogFileWrite('Чтение файла: ' + IniFolder + 'logix.ini');
    ini := TIniFile.Create(IniFolder + 'logix.ini');
//    ini.UpdateFile();
    LastFolderPath := ini.ReadString('MAIN', 'PATH', LastFolderPath);
    ini.Free();
    Utils.LogFileWrite('Файл: ' + IniFolder + 'logix.ini' + ' прочитан учпешно.');
  except
    Utils.LogFileWrite('Проверьте наличие файла logix.ini')
  end;
  GotoFolder(LastFolderPath);
end;

procedure TfrmBrowser.FormDestroy(Sender: TObject);
var
  fn : string;
  ini : TIniFile;
begin
  fn := IniFolder + 'logix.ini';
  try
//    Utils.LogFileWrite('Сохранение в файл: ' + fn);
    ini := TIniFile.Create(fn);
    ini.WriteString('MAIN', 'PATH', GetCurrentPath());
    ini.UpdateFile();
    ini.Free();
//    Utils.LogFileWrite('Сохранение в файл: ' + fn + ' прошло успешно.');
  except
//    Utils.LogFileWrite('ERROR. Значение в файл: ' + fn + 'не сохранёно!')
  end;

  las.Clear;
  las.Free;
end;

procedure TfrmBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBrowser.ShellTreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  LastFolderPath := GetCurrentPath();
end;


(* преобразуем относительно вертикальной оси *)
procedure TfrmBrowser.Mirror1Click(Sender: TObject);
begin
  if las.HMirror(fraLASView.lvLOGs.ItemFocused.Caption) = _OK_ then begin
    las.WriteToLas(las.FileName);
    lvFileBrowser.Update();
  end;
end;

procedure TfrmBrowser.mnuReplaceValueClick(Sender: TObject);
var
  res : TModalResult;
begin
  las.SelectedLOG := las.Logs.LOG(fraLASView.lvLOGs.ItemFocused.Caption);
  with frmReplace do begin
    lf := las;
    res := ShowModal();
  end;
  if (las.Changed) and (res = mrOK) then begin
//сохраняем изменённый файл
    with pbProgress do begin
      min := 0;
      max := 100;
      position := min;
    end;
    CancelFlag := FALSE;
    btnCancelRead.Enabled := FALSE;
    las.init_progress := InitProgress;
    las.do_progress := DoProgress;
    try
      las.WriteToLAS( las.FileName );
    finally
      with pbProgress do begin
        min := 0;
        max := 100;
        position := min;
      end;
    end;
  end;
  lvFileBrowser.Update();
end;

procedure TfrmBrowser.btnSheetViewClick(Sender: TObject);
begin
  with TfrmViewSheet.Create(self) do begin
    Show();
    LoadData( self.las );
  end;
end;

procedure TfrmBrowser.lvFileBrowser1Click(Sender: TObject);
begin
  ChangeFile();
end;

procedure TfrmBrowser.btnFolderUpClick(Sender: TObject);
begin
  lvFileBrowser.Back();
end;

function TfrmBrowser.ChangeFile() : integer;
begin
  result := _ERROR_;
  if (lvFileBrowser.ItemIndex >= 0) then begin
    result := LoadLASFile(lvFileBrowser.Folders[lvFileBrowser.ItemIndex].PathName);
  end;
end;

procedure TfrmBrowser.lvFileBrowserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_F5, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_END, VK_HOME, VK_PRIOR, VK_NEXT] then
    ChangeFile();
end;

procedure TfrmBrowser.chkFiltrateClick(Sender: TObject);
begin
  case chkFiltrate.Checked of
    true:   lvFileBrowser.FileMask := 'LAS';
    false : lvFileBrowser.FileMask := '*';
  end;
  lvFileBrowser.Refresh();
end;

procedure TfrmBrowser.chkOemToAnsiClick(Sender: TObject);
begin
  las.FlagOemToAnsi := chkOemToAnsi.Checked;
end;

end.
