unit common;

interface
uses
  windows, messages, classes, activex, CLas, BiStrList, LOGRecList;

const
(* Имена файлов настроек *)
  LOGS_PARAMETERS_FILENAME = 'logs.ini';

(* Ошибки приложения *)
  _ERR_NO_LOG_SELECT_ = 1001;
  _ERR_INPUT_PARAMETERS_ = 1002;

var
  IniFolder,                      //каталог с файлами настроек
  LogListFileName,                //файл со списком каротажей
  LastFolderPath : string;        //текущий рабочий каталог
  strlstFile,                     //список файлов
  strlstDir      : TStringList;
  strlstAPI      : TBiStrList;    //подстава для идентификаторов скважин
//  strlstLOGid    : TBiStrList;  //подстава для идентификаторов каротажей
  stdLOG         : TLogParamList; //стандартные параметры каротажей. считываются из logs.ini
  lf             : TLASFile;
  PixelsPerInch  : integer;       //значение для текущей машины, считывается при запуске программы.
  SaveDecimalSeparator : char;

implementation

end.
