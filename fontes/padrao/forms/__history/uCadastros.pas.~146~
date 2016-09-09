unit uCadastros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, FMTBcd, DB, Provider,
  DBClient, SqlExpr, ACBrEnterTab, DBCtrls;

type
  TfrmCadastros = class(TForm)
    sbMSG: TStatusBar;
    pnlBotoes: TPanel;
    Botao_Cancelar: TBitBtn;
    Botao_Ok: TBitBtn;
    pnlDados: TPanel;
    dsoCad: TDataSource;
    qryCad: TSQLQuery;
    cdsCad: TClientDataSet;
    dspCad: TDataSetProvider;
    procedure Botao_CancelarClick(Sender: TObject);
    procedure Botao_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    v_id: integer; // campo ID filtrado da GRID
    v_titulo: string;
    v_TabCad: string;

    procedure ajustarLabel();
    function validarField(): boolean;
    procedure msgAjuda(Sender: TObject);
    procedure limparMSG(Sender: TObject);
  end;

var
  frmCadastros: TfrmCadastros;
  tecla_Enter: TACBrEnterTab;
  sql: string;

  // componentes para config dos campos (Label)
  cdsField: TClientDataSet;

implementation

uses uBanco, uFuncoes, udm, UMensagem, uConst, uValidarCampos;

{$R *.dfm}

procedure TfrmCadastros.Botao_OkClick(Sender: TObject);
begin
  // Verifica se os campos obrigatorios foram preenchidos
  if not(validarField) then
  begin
    case Self.Tag of
      C_INSERT:
        begin
          cdsCad.Post;
        end;

      C_UPDATE:
        begin
          cdsCad.Post;
        end;

      C_DELETE:
        begin
          cdsCad.Delete;
        end;
    end;
    cdsCad.ApplyUpdates(0);
    Close;
  end;
end;

procedure TfrmCadastros.ajustarLabel;
var
  i: integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i].ClassType = TLabel then
    begin
      if cdsField.Locate('CAMPO', TLabel(Self.Components[i]).Caption,
        [loCaseInsensitive]) then
      begin
        TLabel(Self.Components[i]).Caption :=
          cdsField.FieldByName('DESCRICAO').AsString;

        // Verificar campo obrigatorio
        if cdsField.FieldByName('OBRIGATORIO').AsInteger = C_SIM then
        begin
          TLabel(Self.Components[i]).Font.Style := [fsBold];
          TLabel(Self.Components[i]).Font.Size := 7;
        end;

      end;
    end;
    if Self.Components[i].ClassType = TDBCheckBox then
    begin
      if cdsField.Locate('CAMPO', TDBCheckBox(Self.Components[i]).Caption,
        [loCaseInsensitive]) then
      begin
        TLabel(Self.Components[i]).Caption :=
          cdsField.FieldByName('DESCRICAO').AsString;
      end;
    end;
  end;
end;

procedure TfrmCadastros.Botao_CancelarClick(Sender: TObject);
begin
  if Self.Tag in [C_INSERT, C_UPDATE] then
  begin
    cdsCad.Cancel;
    cdsCad.CancelUpdates;
  end;
  Close;
end;

procedure TfrmCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Voltando a query original
  qryCad.sql.Clear;
  qryCad.sql.Add(sql);
  Ctrl_DataSet(cdsCad, False);
  destruirSQL(cdsField);
end;

procedure TfrmCadastros.FormCreate(Sender: TObject);
var
  x: integer;
begin
  Self.v_titulo := Self.Caption; // Armazenar o titulo original
  sql := qryCad.sql.Text; // Armazenar a query original

  // ativar tecla Enter (#13)
  tecla_Enter := TACBrEnterTab.Create(Self);
  tecla_Enter.EnterAsTab := True;

  // Associar Evento OnEnter em todos os componentes TDBEdit
  For x := 0 to ComponentCount - 1 do
    if (Components[x] is TDBEdit) then
    begin
      (Components[x] as TDBEdit).OnEnter := msgAjuda;
      (Components[x] as TDBEdit).OnExit := limparMSG;
    end;
end;

procedure TfrmCadastros.FormShow(Sender: TObject);
begin
  if Self.Tag <> C_INSERT then
  begin
    qryCad.sql.Add('Where ' + qryCad.Fields[0].FieldName + ' = :id');
    qryCad.ParamByName('id').AsInteger := v_id;
  end;

  Ctrl_DataSet(cdsCad, True);

  // Configuracao dos Campos - Label e StatusBar (AJUDA)
  criarSQL(cdsField, 'TB_CAMPOS', 'TABELA', v_TabCad, True);
  ajustarLabel;
  case Self.Tag of
    C_INSERT:
      begin
        cdsCad.Append;
        cdsCad.Fields[0].Required := False; // campo autoincremento
        pnlDados.Enabled := True;
      end;

    C_UPDATE:
      begin
        cdsCad.Edit;
        pnlDados.Enabled := True;
      end;

    C_DELETE:
      begin
        pnlDados.Enabled := False;
        Botao_Cancelar.SetFocus;
      end;

    C_BROWSE:
      begin
        pnlDados.Enabled := False;
        Botao_Ok.SetFocus;
      end;
  end;
  sbMSG.SimpleText := '';
end;

procedure TfrmCadastros.limparMSG(Sender: TObject);
begin
  sbMSG.SimpleText := '';
end;

procedure TfrmCadastros.msgAjuda(Sender: TObject);
var
  c: integer;
begin
  For c := 0 to ComponentCount - 1 do
  begin
    if (Components[c] is TDBEdit) then
    begin
      if TDBEdit(Components[c]).Focused then
      begin
        if cdsField.Locate('CAMPO', TDBEdit(Self.Components[c]).DataField,
          [loCaseInsensitive]) then
          sbMSG.SimpleText := cdsField.FieldByName('AJUDA').AsString;
      end;
    end;
  end;
end;

function TfrmCadastros.validarField: boolean;
var
  fVal: TFrmValidarCampos;
begin
  fVal := TFrmValidarCampos.Create(Self);
  fVal.qryVal.SQLConnection := qryCad.SQLConnection;
  Result := fVal.validarCampos(cdsCad, v_TabCad);
  fVal.Free;
end;

end.
