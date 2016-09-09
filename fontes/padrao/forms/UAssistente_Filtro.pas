unit UAssistente_Filtro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, DBCtrls, AdoDb, DB, SqlExpr, Provider,
  Grids, DBGrids;

type
  TFrAssistenteFiltro = class(TForm)
    PnMaterial: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    BtPesquisa: TSpeedButton;
    EdValor: TEdit;
    EdOperador: TComboBox;
    EdCampo: TComboBox;
    DsPesquisa: TDataSetProvider;
    SpeedButton1: TSpeedButton;
    gridPesquisar: TDBGrid;
    Function execute(lQuery: TSQLQuery): String;
    procedure BtPesquisaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrAssistenteFiltro: TFrAssistenteFiltro;
  lFiltro: String;

implementation

{$R *.dfm}
{ TFrAssistenteFiltro }

{ TFrAssistenteFiltro }

function TFrAssistenteFiltro.execute(lQuery: TSQLQuery): String;
var
  i: integer;
begin
  DsPesquisa.DataSet := lQuery;

  For i := 0 To DsPesquisa.DataSet.FieldCount - 1 do
  begin
    EdCampo.Items.Add(DsPesquisa.DataSet.Fields[i].DisplayLabel);
  end;

  EdCampo.ItemIndex := 0;
  EdOperador.ItemIndex := 0;

  Showmodal;

  if lFiltro = '' then
    Result := ' WHERE 1=1'
  else
    Result := ' WHERE ' + lFiltro;

end;

procedure TFrAssistenteFiltro.SpeedButton1Click(Sender: TObject);
begin
  close;
end;

procedure TFrAssistenteFiltro.BtPesquisaClick(Sender: TObject);
var
  lCampo: String;
  lOperador: String;

  function f_operador(lOperador: String): string;

  begin
    if lOperador = 'Todos' then
      Result := '1 = 1'
    else if lOperador = 'Igual' then
      Result := '='
    else if lOperador = 'maior ou igual' then
      Result := '>='
    else if lOperador = 'menor ou igual' then
      Result := '<='
    else if lOperador = 'contem' then
      Result := 'LIKE'
    else if lOperador = 'entre' then
      Result := 'BETWEEN';

  end;

begin
  lFiltro := '';
  lOperador := '';
  lCampo := '';

  lOperador := f_operador(EdOperador.Text);

  lCampo := DsPesquisa.DataSet.Fields[EdCampo.ItemIndex].FieldName;

  if EdValor.Text <> '' then
  begin
    // campos texto
    if DsPesquisa.DataSet.FieldbyName(lCampo) is TstringField then
      if lOperador = 'LIKE' then
        lFiltro := lCampo + ' ' + lOperador + ' ' +
          QuotedStr('%' + EdValor.Text + '%')
      else
        lFiltro := lCampo + ' ' + lOperador + ' ' + QuotedStr(EdValor.Text)

    else
    // campos data
      if DsPesquisa.DataSet.FieldbyName(lCampo) is TDateField then
      lFiltro := lCampo + ' ' + lOperador + ' ' +
        QuotedStr(FormatDateTime('yyyy-mm-dd', StrtoDate(EdValor.Text)))

    else
      // campos integer
      lFiltro := lCampo + ' ' + lOperador + ' ' + EdValor.Text;

  end
  else
    lFiltro := '1=1';

  close;
end;

end.
