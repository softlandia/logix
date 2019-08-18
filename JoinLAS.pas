unit JoinLAS;
{Join log from one las file to other}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AddLAS, ImgList, LASView, ComCtrls, CLas, Menus, Utils, FloatList, ToolWin,
  System.ImageList;

type
{Form class }
  TfrmJoinLAS = class(TfrmAddLAS)
    procedure btnAddLASClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraLASView2lvLOGsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure fraLASView1lvLOGsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure fraLASView1lvLOGsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure fraLASView2lvLOGsEndDrag(Sender, Target: TObject; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJoinLAS: TfrmJoinLAS;

implementation
{$R *.DFM}
//Add to list SelectedItemList all selected in ListView items
//Return count of items was added to list
//If not items selected then return 0
//Output list do not clear
function  GetSelectedItems( const listview : TListView; SelectedItemList : TList ): integer;
var
  li : TListItem;
begin
  result := 0;
  if listview.SelCount = 0 then
    exit;
  if listview.SelCount = 1 then begin
    SelectedItemList.Add( listview.Selected );
    result := 1;
    exit;
  end;
  li := listview.Selected;
  while li <> nil do begin
    SelectedItemList.Add( li );
    inc(result);
    li := listview.GetNextItem(li, sdAll, [isSelected]);
  end;
end;

{do join
 Добавление выбранных каротажей из одного файла в другой,
 колонка глубин должна совподать
}
procedure TfrmJoinLAS.btnAddLASClick(Sender: TObject);
var
  d, v,
  y : TxFloatList;
  i, count : integer;
  logs: TList;
  s   : string;
begin
  logs := TList.Create();
  y := TxFloatList.Create();
  try
    count := GetSelectedItems( fraLASView2.lvLOGs, logs );
    if count = 0 then begin
      MessageDlg('Выберите в правом окне один или несколько каротажей', mtInformation, [mbOk], 0);
      exit;
    end;
//колонка глубины из добавляемого файла у всех коратажей одна
    d := lf2.Logs.y(0);
    s := '';
    for i := 0 to count-1 do begin
//Готовим исходные массивы
      v := lf2.Logs.y(TListItem(logs[i]).Caption);
//Интерполируем не регулярные данные d, v в регулярный по глубине список y
      NormalizeXYZ( lf1._STRT, lf1._STOP, lf1._STEP, lf1._NULL, //нач. конечная глубина, шаг и пустое значение
                    d, v,                                       //Глубина/значение добавляемого файла
                    y);                                         //Результирующий список
      if y.Count <> lf1.logs.log(0).y.count then begin
        exit;
      end;
      s := s + lf2.Logs.LOG(TListItem(logs[i]).Caption).Id + ', ';
      lf1.AddLog(lf2.Logs.LOG(TListItem(logs[i]).Caption).Id,
                 lf2.Logs.LOG(TListItem(logs[i]).Caption).aUNIT, y );
//Очищаем список от уже добавленного каротажа
      y.Clear();
    end;
    if length(FileNameAs) = 0 then
      FileNameAs := lf1.FileName;
    if MessageDlg( Format('В файл %-s были добавлены каротажи: %-s сохранить изменения в файле %-s?', [lf1.FileName, s, FileNameAs]), mtWarning, [mbYes, mbNo], 0) = mrYes then
      lf1.WriteToLAS(FileNameAs);
  finally
    y.Free();
    logs.free();
  end;
//Устанавливаем состояние списков согласно изменениям
  s := lf1.FileName;
  lf1.Clear();
  lf1.Open(s);
  InitListView( fraLASView1.lvHeader, fraLASView1.lvLOGs, lf1 );
end;

procedure TfrmJoinLAS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmJoinLAS.fraLASView2lvLOGsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  with Sender as TListView do begin
    if ItemIndex >= 0 then
      BeginDrag(False);
  end;
end;

procedure TfrmJoinLAS.fraLASView1lvLOGsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := (Source is TListView) and ((Sender as TListView).Items.Count > 0);
end;

procedure TfrmJoinLAS.fraLASView1lvLOGsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  inherited;
  if (Source is TListView) then begin
    btnAddLASClick(btnAddLas);
  end;
end;

procedure TfrmJoinLAS.fraLASView2lvLOGsEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  inherited;
  if Target <> nil then;
end;

end.
