unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastros, FMTBcd, DB, DBClient, Provider, SqlExpr, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Mask, DBCtrls, ADODB;

type
  TfCadBanco = class(TfrmCadastros)
    qryCadID_BANCO: TIntegerField;
    qryCadCOD_BANCO: TIntegerField;
    qryCadBANCO: TStringField;
    cdsCadID_BANCO: TIntegerField;
    cdsCadCOD_BANCO: TIntegerField;
    cdsCadBANCO: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCadBanco: TfCadBanco;

implementation

uses udm;

{$R *.dfm}

end.
