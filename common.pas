unit common;

interface
uses
  windows, messages, classes, activex, CLas, BiStrList, LOGRecList;

const
(* ����� ������ �������� *)
  LOGS_PARAMETERS_FILENAME = 'logs.ini';

(* ������ ���������� *)
  _ERR_NO_LOG_SELECT_ = 1001;
  _ERR_INPUT_PARAMETERS_ = 1002;

var
  IniFolder,                      //������� � ������� ��������
  LogListFileName,                //���� �� ������� ���������
  LastFolderPath : string;        //������� ������� �������
  strlstFile,                     //������ ������
  strlstDir      : TStringList;
  strlstAPI      : TBiStrList;    //�������� ��� ��������������� �������
//  strlstLOGid    : TBiStrList;  //�������� ��� ��������������� ���������
  stdLOG         : TLogParamList; //����������� ��������� ���������. ����������� �� logs.ini
  lf             : TLASFile;
  PixelsPerInch  : integer;       //�������� ��� ������� ������, ����������� ��� ������� ���������.
  SaveDecimalSeparator : char;

implementation

end.
