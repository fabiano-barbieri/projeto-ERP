unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ribbon, RibbonLunaStyleActnCtrls, PlatformDefaultStyleActnCtrls,
  ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus, RibbonActnMenus, ImgList,
  StdActns, ExtActns, Buttons, ExtCtrls, pngimage, Menus, jpeg, StdCtrls,
  ActnPopup;

type
  TFrMenu = class(TForm)
    RbMenu: TRibbon;
    RbCadastro: TRibbonPage;
    ActionManager1: TActionManager;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    BrowseURL1: TBrowseURL;
    DownLoadURL1: TDownLoadURL;
    SendMail1: TSendMail;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    GrClientes: TRibbonGroup;
    ImageList1: TImageList;
    GrFornecedores: TRibbonGroup;
    GrTransportadores: TRibbonGroup;
    GrFuncionarios: TRibbonGroup;
    GrVendedor: TRibbonGroup;
    ImClientes: TImage;
    ImFornecedores: TImage;
    ImTransportadores: TImage;
    ImFuncionarios: TImage;
    ImVendedor: TImage;
    RbFinanceiro: TRibbonPage;
    RbEstoque: TRibbonPage;
    RbProdutoServico: TRibbonPage;
    RibbonPage1: TRibbonPage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PPusuario: TPopupMenu;
    PpAlterarUsuario: TMenuItem;
    PpSair: TMenuItem;
    GrContas_Pagar: TRibbonGroup;
    ImContasPagar: TImage;
    RbProdutos: TRibbonGroup;
    RbServico: TRibbonGroup;
    GrContas_Receber: TRibbonGroup;
    GrNota_Fiscal_Entrada: TRibbonGroup;
    GrNota_Fiscal_Saida: TRibbonGroup;
    RbMovimentacoes: TRibbonGroup;
    RbCaixa: TRibbonGroup;
    GrPedidos: TRibbonGroup;
    GrOrcamentos: TRibbonGroup;
    RbConfiguracoes: TRibbonPage;
    RibbonGroup4: TRibbonGroup;
    RibbonGroup5: TRibbonGroup;
    Image7: TImage;
    Image8: TImage;
    ImPedidos: TImage;
    ImOrcamentos: TImage;
    Image13: TImage;
    Image12: TImage;
    Image14: TImage;
    ImContasReceber: TImage;
    ImNotaEntrada: TImage;
    ImNotaSaida: TImage;
    ImCaixa: TImage;
    pnlGrid: TPanel;
    RibbonGroup2: TRibbonGroup;
    Action1: TAction;
    Action2: TAction;
    RibbonPage2: TRibbonPage;
    RbSair: TRibbonGroup;
    Image19: TImage;
    Image20: TImage;
    ImLogoEmpresa: TImage;
    RibbonGroup6: TRibbonGroup;
    Image21: TImage;
    GrUsuarios: TRibbonGroup;
    Image5: TImage;
    procedure PpSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure ImClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure tamanhoGrid();
  end;

var
  FrMenu: TFrMenu;

implementation

uses uBanco, UMensagem, uFuncoes, uConst, Unit1, Unit2, IniFiles, udm;

{$R *.dfm}

procedure TFrMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrMenu.Destroy;
end;

procedure TFrMenu.FormShow(Sender: TObject);
var ArqIniConn : TIniFile;
begin
  RbMenu.TabIndex := 0;

  ArqIniConn := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'sisfin.ini');
  dmodule.conexao.Connected:= False;
  conexaoDB(dmodule.conexao, ArqIniConn);
  dmodule.conexao.Connected:= True;
  ArqIniConn.Free;
end;

procedure TFrMenu.Image19Click(Sender: TObject);
begin
  Close;
  Application.Terminate;
end;

procedure TFrMenu.ImClientesClick(Sender: TObject);
begin
  tamanhoGrid;
  fGridBanco := TfGridBanco.Create(Application);
  fCadBanco := TfCadBanco.Create(Application);
  fGridBanco.fCad := fCadBanco;
  fGridBanco.v_TabGrid := 'TB_BANCO';
  fGridBanco.Show;
end;

procedure TFrMenu.PpSairClick(Sender: TObject);
begin
  Close;
  Application.Terminate;
end;

procedure TFrMenu.tamanhoGrid;
begin
  V_Grid_Width := pnlGrid.Width;
  V_Grid_Height := pnlGrid.Height + 35;
  V_Grid_Top := pnlGrid.Top;
  V_Grid_Left := pnlGrid.Left;
end;

end.
