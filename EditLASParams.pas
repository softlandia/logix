unit EditLASParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmEditLASParams = class(TForm)
    Label1: TLabel;
    edFieldName: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edFieldValue: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditLASParams: TfrmEditLASParams;

implementation

{$R *.DFM}

end.
