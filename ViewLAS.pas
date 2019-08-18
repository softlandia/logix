////////////////////////////////////////////////////////////////////////////////
//Ôמנלא הכÿ ןנמסלמענא las פאיכא מענאבאעûגאוע קונוח פנויל "LASView"
//ver   1.0.2
//date  22.04.2001
//autor softland@zmail.ru
////////////////////////////////////////////////////////////////////////////////
unit ViewLAS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, CLas, Utils, Common,
  ToolWin, LASView;

const
  CFormCaption = 'View LAS file: ';
  CPntCountCaption = 'Total read points: ';

type
  TfrmViewLAS = class(TForm)
    fraLASView: TfraLASView;
    ToolBar1: TToolBar;
    sbStatus: TStatusBar;
    procedure FormShow(Sender: TObject);
  end;

var
  frmViewLAS: TfrmViewLAS;

implementation

{$R *.DFM}

procedure TfrmViewLAS.FormShow(Sender: TObject);
begin
  fraLASView.InitListView(lf);
  sbStatus.Panels[0].Text := CPntCountCaption + IntToStr(lf.logs.y(0).Count);
  self.Caption := CFormCaption + lf.FileName;
end;

end.
