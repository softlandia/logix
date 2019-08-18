program logix;

uses
  Utils,
  SysUtils,
  Forms,
  main in 'main.pas',
  common in 'common.pas',
  AddLogAliace in 'AddLogAliace.pas' {frmAddNewLOGaliace},
  AddLAS in 'AddLAS.pas' {frmAddLAS},
  APIcode in 'APIcode.pas' {frmAPIcode},
  BaseDlg in 'BaseDlg.pas' {frmBaseDlg},
  browser in 'browser.pas' {frmBrowser},
  CreateLas in 'CreateLas.pas' {frmCreateLAS},
  ChartHeaderInfo in 'ChartHeaderInfo.pas' {frmChartHeaderInfo},
  ChartPref in 'ChartPref.pas' {frmChartPref},
  ChartExport in 'ChartExport.pas' {frmChartExport},
  ChangeLOGid in 'ChangeLOGid.pas' {frmChangeLogId},
  EditLOGid in 'EditLOGid.pas' {frmEditLOGid},
  EditLASParams in 'EditLASParams.pas' {frmEditLASParams},
  JoinLAS in 'JoinLAS.pas' {frmJoinLAS},
  LASView in 'LASView.pas' {fraLASView: TFrame},
  LOGChart in 'LOGChart.pas' {frmLogChart},
  LogList in 'LogList.pas' {frmLogList},
  preferences in 'preferences.pas' {frmPreferences},
  Replace in 'Replace.pas' {frmReplace},
  ViewSheet in 'ViewSheet.pas' {frmViewSheet},
  ViewXYZfile in 'ViewXYZfile.pas' {frmViewXYZfile},
  IniFiles,
  CLAS in 'X:\lib\xLib\CLAS.pas',
  AScript in 'X:\lib\xLib\AScript.pas',
  biStrList in 'X:\lib\xLib\biStrList.pas',
  floatlist in 'X:\lib\xLib\floatlist.pas',
  LOGRecList in 'X:\lib\xLib\LOGRecList.pas',
  Painter in 'X:\lib\xLib\Painter.pas',
  PainterBox in 'X:\lib\xLib\PainterBox.pas',
  xGraf in 'X:\lib\xLib\xGraf.pas',
  xSeries in 'X:\lib\xLib\xSeries.pas',
  ShellCtrls in 'X:\lib\ShellControls\ShellCtrls.pas',
  AboutBox in 'AboutBox.pas' {frmAboutBox};

{$R *.RES}

///	<summary>
///	    »нициализаци€ основных параметров.
///	    –азбор параметров коммандной строки.
///	</summary>
///	<remarks>
///	  <para> ѕараметры коммандной строки </para>
///	  <para> 1-й Ч ‘олдер†который надо открыть (игнорируетс€) </para>
///	  <para> 2-й†Ч »м€ файла дл€ сохранени€ списка каротажа </para>
///	</remarks>
function Init() : integer;
begin
  PixelsPerInch := Screen.PixelsPerInch;
  IniFolder := AddBackSlash(ExtractFilePath(ParamStr(0)));
  if ParamCount >= 1 then begin
    IniFolder := AddBackSlash(ExtractFilePath(ParamStr(1)));
    if ParamCount = 2 then
      LogListFileName := ParamStr(2);
  end else if ParamCount = 0 then begin
    LogListFileName := AddBackSlash(IniFolder+'loglist.txt');
  end;
  result := _OK_;
end;

begin
  Utils.OpenLogFile(ParamStr(0)+'.log');
  Init();
  Application.Initialize();

  Application.Title := 'LAS tools';
  Application.HelpFile := 'C:\Program Files\logix\Logix.hlp';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAboutBox, frmAboutBox);
  //  Application.CreateForm(TfrmBrowser, frmLASBrowser);
  Application.CreateForm(TfrmLogList, frmLogList);
  Application.CreateForm(TfrmAPIcode, frmAPIcode);
  Application.CreateForm(TfrmAddLAS, frmAddLAS);
  Application.CreateForm(TfrmEditLOGid, frmEditLOGid);
  Application.CreateForm(TfrmEditLASParams, frmEditLASParams);
  Application.CreateForm(TfrmChartHeaderInfo, frmChartHeaderInfo);
  Application.CreateForm(TfrmChartPref, frmChartPref);
  Application.CreateForm(TfrmJoinLAS, frmJoinLAS);
  Application.CreateForm(TfrmReplace, frmReplace);
  Application.CreateForm(TfrmViewSheet, frmViewSheet);
  Application.CreateForm(TfrmPreferences, frmPreferences);
  Application.CreateForm(TfrmAddNewLOGaliace, frmAddNewLOGaliace);
  Application.Run();
  Utils.CloseLogFile();
end.
