unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGrids, FMTBcd, PlatformDefaultStyleActnCtrls, Menus, ActnPopup,
  Provider, DB, DBClient, SqlExpr, Grids, DBGrids, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, CheckLst, ADODB;

type
  TfGridBanco = class(TfrmGrids)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGridBanco: TfGridBanco;

implementation

uses udm, unit2,  uBanco, uFuncoes;

{$R *.dfm}

end.
