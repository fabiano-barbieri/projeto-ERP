unit uValidarCampos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TFrmValidarCampos = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lbCampos: TListBox;
    Panel1: TPanel;
    Botao_Ok: TBitBtn;
    qryVal: TSQLQuery;
    dspVal: TDataSetProvider;
    cdsVal: TClientDataSet;
    procedure Botao_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    function validarCampos(cds: TClientDataSet; tabela: string): boolean;
  end;

var
  FrmValidarCampos: TFrmValidarCampos;

implementation

uses uBanco, uFuncoes, udm, UMensagem, uConst;

{$R *.dfm}

procedure TFrmValidarCampos.Botao_OkClick(Sender: TObject);
begin
  Close;
end;

function TFrmValidarCampos.validarCampos(cds: TClientDataSet;
  tabela: string): boolean;
begin
  Ctrl_DataSet(cdsVal, False);
  qryVal.ParamByName('V_TABELA').AsString := tabela;
  Ctrl_DataSet(cdsVal, True);

  Result:= False;
  if not cdsVal.IsEmpty then
  begin
    cdsVal.First;
    while not cdsVal.Eof do
    begin
      if Trim(cds.FieldByName(cdsVal.FieldByName('CAMPO').AsString).AsString) = '' then
      begin
        lbCampos.Items.Add(cdsVal.FieldByName('DESCRICAO').AsString);
      end;
      cdsVal.Next;
    end;
    if lbCampos.Items.Count > 0 then
    begin
      Result:= True;
      ShowModal;
    end;
  end;
end;

end.
