unit JoinWizard;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Dialogs, Buttons, CLas;

const
  Caption1 = 'Ïונגûי LAS פאיכ: ';
  Caption2 = 'Âעמנמי LAS פאיכ: ';
  Caption3 = 'Èעמדמגûי LAS פאיכ: ';

type
  TfrmJoinWizard = class(TForm)
    btnJoinLasFiles: TButton;
    Button2: TButton;
    Button3: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    btnFile1: TSpeedButton;
    Label1: TLabel;
    btnFile2: TSpeedButton;
    btnFileRes: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    procedure btnFile1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFile2Click(Sender: TObject);
    procedure btnFileResClick(Sender: TObject);
    procedure btnJoinLasFilesClick(Sender: TObject);
  public
    lasfile1,
    lasfile2,
    lasfileres : TLasFile;
  end;

var
  frmJoinWizard: TfrmJoinWizard;

implementation

{$R *.DFM}

procedure TfrmJoinWizard.FormCreate(Sender: TObject);
begin
  lasfile1 := TLasFile.Create;
  lasfile2 := TLasFile.Create;
  lasfileres := TLasFile.Create;
end;

procedure TfrmJoinWizard.FormDestroy(Sender: TObject);
begin
  lasfileres.Free;
  lasfile2.Free;
  lasfile1.Free;
end;

procedure TfrmJoinWizard.btnFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    lasfile1.FileName := OpenDialog1.FileName;
    Label1.Caption := Caption1 + OpenDialog1.FileName;
    lasfile1.ReadFromLAS( lasfile1.FileName );
  end;
end;

procedure TfrmJoinWizard.btnFile2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    lasfile2.FileName := OpenDialog1.FileName;
    Label2.Caption := Caption2 + OpenDialog1.FileName;
  end;
end;

procedure TfrmJoinWizard.btnFileResClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    lasfileres.FileName := OpenDialog1.FileName;
    Label3.Caption := Caption3 + OpenDialog1.FileName;
  end;
end;

procedure TfrmJoinWizard.btnJoinLasFilesClick(Sender: TObject);
var
  i : integer;
begin
  lasfile2.ReadFromLAS( lasfile2.FileName );
  for i := 0 to lasfile1.logs.Count-1 do begin
    lasfile1.AddLogData( i, lasfile2.logs.log(i));
  end;
  lasfile1.header.SetValueAsFloat('STRT', lasfile1.logs.y(0).max);
  lasfile1.header.SetValueAsFloat('STOP', lasFile1.logs.y(0).max);
  lasfile1.WriteToLas( lasfileres.filename );
end;

end.
