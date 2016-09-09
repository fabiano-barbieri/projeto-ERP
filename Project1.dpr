program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fGridBanco},
  Unit2 in 'Unit2.pas' {fCadBanco},
  udm in 'udm.pas' {dmodule: TDataModule},
  UAssistente_Filtro in 'C:\ERP\fontes\padrao\forms\UAssistente_Filtro.pas' {FrAssistenteFiltro},
  uCadastros in 'C:\ERP\fontes\padrao\forms\uCadastros.pas' {frmCadastros},
  uGrids in 'C:\ERP\fontes\padrao\forms\uGrids.pas' {frmGrids},
  UMensagem in 'C:\ERP\fontes\padrao\forms\UMensagem.pas' {FrMensagem},
  UMenu in 'C:\ERP\fontes\padrao\forms\UMenu.pas' {FrMenu},
  uBanco in 'C:\ERP\fontes\padrao\units\uBanco.pas',
  uConst in 'C:\ERP\fontes\padrao\units\uConst.pas',
  uFuncoes in 'C:\ERP\fontes\padrao\units\uFuncoes.pas',
  uValidarCampos in 'C:\ERP\fontes\padrao\forms\uValidarCampos.pas' {FrmValidarCampos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdmodule, dmodule);
  Application.CreateForm(TFrMenu, FrMenu);
  Application.Run;
end.
