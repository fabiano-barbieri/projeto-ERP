unit uGrids;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  ImgList, uCadastros, Provider, SqlExpr, DBClient, DB, DBXFirebird, FMTBcd,
  Menus, ActnPopup, CheckLst, ComObj, PlatformDefaultStyleActnCtrls;

type
  TfrmGrids = class(TForm)
    pnlBotoes: TPanel;
    pnlGrid: TPanel;
    sbMsg: TStatusBar;
    Botao_Insert: TBitBtn;
    Botao_Update: TBitBtn;
    Botao_Delete: TBitBtn;
    Botao_View: TBitBtn;
    Botao_Print: TBitBtn;
    Botao_Report: TBitBtn;
    Botao_Transf: TBitBtn;
    Botao_Campos: TBitBtn;
    Botao_Search: TBitBtn;
    Botao_Exit: TBitBtn;
    Botao_Export: TBitBtn;
    dsoGrid: TDataSource;
    menuGrid: TPopupActionBar;
    Grid: TDBGrid;
    pnlCampos: TPanel;
    cbCampos: TCheckListBox;
    rbTodos: TRadioButton;
    rbNenhum: TRadioButton;
    dspGrid: TDataSetProvider;
    cdsGrid: TClientDataSet;
    qryGrid: TSQLQuery;
    Botao_Reflesh: TBitBtn;
    procedure Botao_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Botao_InsertClick(Sender: TObject);
    procedure Botao_UpdateClick(Sender: TObject);
    procedure Botao_DeleteClick(Sender: TObject);
    procedure Botao_ViewClick(Sender: TObject);
    procedure Botao_CamposClick(Sender: TObject);
    procedure rbTodosClick(Sender: TObject);
    procedure rbNenhumClick(Sender: TObject);
    procedure GridTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbCamposClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Botao_PrintClick(Sender: TObject);
    procedure Botao_ReportClick(Sender: TObject);
    procedure Botao_ExportClick(Sender: TObject);
    procedure Botao_TransfClick(Sender: TObject);
    procedure Botao_SearchClick(Sender: TObject);
    procedure Botao_RefleshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    fCad: TfrmCadastros;
    v_TabGrid: string;

    procedure abrirCad(Operacao: integer; caption: string);
    procedure ordenaGrid(campo: string; ordem: string);
    procedure camposGrid();
    procedure layoutGrid();
    procedure exportGrid();
    procedure sqlGrid();
    procedure registroGrid();
    procedure ajustarTitulo();

  end;

var
  fGrids: TfrmGrids;
  sql: string;
  v_ordem: string;

  // componentes para config dos campos (Titulo Grid)
  cdsField: TClientDataSet;

implementation

uses uBanco, uFuncoes, UMensagem, UAssistente_Filtro, uConst;

{$R *.dfm}

procedure TfrmGrids.abrirCad(Operacao: integer; caption: string);
begin
  fCad.Tag := Operacao;
  fCad.v_id := cdsGrid.Fields[0].AsInteger;
  fCad.caption := fCad.v_titulo + ' - ' + caption;
  fCad.V_TabCad := v_TabGrid;
  fCad.ShowModal;
  cdsGrid.Refresh;
  registroGrid;
end;

procedure TfrmGrids.ajustarTitulo;
var
  i: integer;
begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if cdsField.Locate('CAMPO', Grid.Columns[i].FieldName,
      [loCaseInsensitive]) then
      Grid.Columns.Items[i].Title.caption :=
        cdsField.FieldByName('DESCRICAO').AsString;
  end;
end;

procedure TfrmGrids.Botao_CamposClick(Sender: TObject);
begin
  if pnlCampos.Visible = True then
  begin
    pnlCampos.Visible := False;
    Grid.Align := alClient;
  end
  else
  begin
    pnlCampos.Visible := True;
    pnlCampos.Height := Grid.Height - 1;
    pnlCampos.Top := 0;
    pnlCampos.Left := 0;
    cbCampos.Height := pnlCampos.Height - 30;
    Grid.Align := alNone;
    Grid.Left := pnlCampos.Width + 1;
  end;
end;

procedure TfrmGrids.Botao_DeleteClick(Sender: TObject);
begin
  if Botao_Delete.Visible = False then
    exit;
  abrirCad(C_DELETE, 'Exclus�o');
end;

procedure TfrmGrids.Botao_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGrids.Botao_ExportClick(Sender: TObject);
begin
  if Botao_Export.Visible = False then
    exit;
  exportGrid;
end;

procedure TfrmGrids.Botao_InsertClick(Sender: TObject);
begin
  abrirCad(C_INSERT, 'Inclus�o');
end;

procedure TfrmGrids.Botao_PrintClick(Sender: TObject);
begin
  if Botao_Print.Visible = False then
    exit;
end;

procedure TfrmGrids.Botao_RefleshClick(Sender: TObject);
begin
  Ctrl_DataSet(cdsGrid, False);
  sqlGrid;
  Ctrl_DataSet(cdsGrid, True);
end;

procedure TfrmGrids.Botao_ReportClick(Sender: TObject);
begin
  if Botao_Report.Visible = False then
    exit;
end;

procedure TfrmGrids.Botao_SearchClick(Sender: TObject);
begin
  FrAssistenteFiltro := TFrAssistenteFiltro.Create(Self);
  sqlGrid;
  qryGrid.sql.Add(FrAssistenteFiltro.execute(qryGrid));
  Ctrl_DataSet(cdsGrid, True);
  cdsGrid.Refresh;
end;

procedure TfrmGrids.Botao_TransfClick(Sender: TObject);
begin
  if Botao_Transf.Visible = False then
    exit;
  fCad.v_id := cdsGrid.Fields[0].AsInteger;
  Close;
end;

procedure TfrmGrids.Botao_UpdateClick(Sender: TObject);
begin
  if Botao_Update.Visible = False then
    exit;
  abrirCad(C_UPDATE, 'Altera��o');
end;

procedure TfrmGrids.Botao_ViewClick(Sender: TObject);
begin
  if Botao_View.Visible = False then
    exit;
  abrirCad(C_BROWSE, 'Visualiza��o');
end;

procedure TfrmGrids.camposGrid;
var
  i: integer;
begin
  pnlCampos.Visible := False;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    cbCampos.Items.Add(Grid.Columns.Items[i].Title.caption);
    if Grid.Columns.Items[i].Visible = True then
      cbCampos.Checked[i] := True
    else
      cbCampos.Checked[i] := False;
  end;
end;

procedure TfrmGrids.cbCamposClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to cbCampos.Count - 1 do
  begin
    if (cbCampos.Checked[i] = True) then
      Grid.Columns.Items[i].Visible := True
    else
      Grid.Columns.Items[i].Visible := False;
  end;
end;

procedure TfrmGrids.layoutGrid;
begin
  Self.Width := V_Grid_Width;
  Self.Height := V_Grid_Height;
  Self.Top := V_Grid_Top;
  Self.Left := V_Grid_Left;
end;

procedure TfrmGrids.ordenaGrid(campo: string; ordem: string);
begin
  Ctrl_DataSet(cdsGrid, False);
  sqlGrid;
  qryGrid.sql.Add('ORDER BY ' + campo + ' ' + ordem);
  Ctrl_DataSet(cdsGrid, True);
end;

procedure TfrmGrids.exportGrid;
begin
  //
end;

procedure TfrmGrids.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sqlGrid;
  Ctrl_DataSet(cdsGrid, False);
  Ctrl_DataSet(cdsField, False);
end;

procedure TfrmGrids.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmGrids.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    // insert/update/delete/view
    VK_F12:
      Botao_ViewClick(Self);
    VK_INSERT:
      Botao_InsertClick(Self);
    VK_DELETE:
      Botao_DeleteClick(Self);
    VK_RETURN:
      Botao_UpdateClick(Self);

    // print/report/export
    VK_F9:
      Botao_PrintClick(Self);
    VK_F10:
      Botao_ReportClick(Self);
    VK_F11:
      Botao_ExportClick(Self);

    // utilitarios/sair
    VK_F2:
      Botao_TransfClick(Self);
    VK_F3:
      Botao_CamposClick(Self);
    VK_F4:
      Botao_SearchClick(Self);
    VK_F5:
      Botao_RefleshClick(Self);
    VK_ESCAPE:
      Botao_ExitClick(Self);

  end;
end;

procedure TfrmGrids.FormShow(Sender: TObject);
begin
  sql := 'SELECT * FROM ' + v_TabGrid;
  qryGrid.SQLConnection := connect;
  qryGrid.sql.Clear;
  qryGrid.sql.Add(sql);
  Ctrl_DataSet(cdsGrid, True);
  layoutGrid;
  registroGrid;

  // Configuracao dos Campos - titulo Grid
  criarSQL(cdsField, 'TB_CAMPOS', 'TABELA', v_TabGrid, True);
  ajustarTitulo;
  camposGrid;
end;

procedure TfrmGrids.GridTitleClick(Column: TColumn);
var
  i: integer;
begin
  for i := 0 to Grid.Columns.Count - 1 do
    Grid.Columns[i].Title.Font.Color := clBlack;

  if v_ordem = 'DESC' then
    v_ordem := 'ASC'
  else
    v_ordem := 'DESC';

  ordenaGrid(Column.FieldName, v_ordem);

  Column.Title.Font.Color := clRed;
end;

procedure TfrmGrids.rbNenhumClick(Sender: TObject);
begin
  cbCampos.CheckAll(cbUnchecked, True, True);
  cbCamposClick(Sender);
end;

procedure TfrmGrids.rbTodosClick(Sender: TObject);
begin
  cbCampos.CheckAll(cbChecked, True, True);
  cbCamposClick(Sender);
end;

procedure TfrmGrids.registroGrid;
begin
  // verificar se existem registros na tabela e habilitar os botoes
  if TabelaVazia(cdsGrid) then
  begin
    Botao_Update.Visible := False;
    Botao_Delete.Visible := False;
    Botao_View.Visible := False;

    Botao_Print.Visible := False;
    Botao_Report.Visible := False;
    Botao_Export.Visible := False;

    Botao_Campos.Visible := False;
    Botao_Search.Visible := False;
  end;

  // Habilitar botao Transf apenas quando necessario
  Botao_Transf.Visible := V_Transf;
  sbMsg.SimpleText := 'Quantidade de Registros >> ' +
    IntToStr(cdsGrid.RecordCount);

end;

procedure TfrmGrids.sqlGrid;
begin
  qryGrid.sql.Clear;
  qryGrid.sql.Add(sql);
end;

end.
