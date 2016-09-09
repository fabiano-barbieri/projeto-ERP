unit udm;

interface

uses
  SysUtils, Classes, DBXFirebird, DB, SqlExpr, ADODB, uBanco;

type
  Tdmodule = class(TDataModule)
    conexao: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmodule: Tdmodule;

implementation

{$R *.dfm}

procedure Tdmodule.DataModuleCreate(Sender: TObject);
begin
  connect:= conexao;
end;

end.
