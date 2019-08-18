unit EditLOGid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmEditLOGid = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    edLOGid: TEdit;
    Label1: TLabel;
    edUnit: TEdit;
    Label2: TLabel;
    min: TLabel;
    max: TLabel;
    edMin: TEdit;
    edMax: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditLOGid: TfrmEditLOGid;

implementation

{$R *.DFM}

end.
