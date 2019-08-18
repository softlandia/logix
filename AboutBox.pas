unit AboutBox;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TfrmAboutBox = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutBox: TfrmAboutBox;

implementation

{$R *.DFM}

procedure TfrmAboutBox.FormCreate(Sender: TObject);
begin
//  Version.Caption := '1.0.0.' + Application
end;

procedure TfrmAboutBox.Image1Click(Sender: TObject);
begin
  Close();
end;

end.
 
