unit UMensagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, pngimage;

Type
  TImagens = (ImPergunta, ImInfo, ImErro, ImAlert);

type
  TFrMensagem = class(TForm)
    Panel1: TPanel;
    PnMensagem: TPanel;
    BtConfirma: TSpeedButton;
    BtNao: TSpeedButton;
    BtCancelar: TSpeedButton;
    ImAlerta: TImage;
    ImInformacao: TImage;
    ImError: TImage;
    ImPergunta: TImage;
    lbMensagem: TLabel;
    procedure BtConfirmaClick(Sender: TObject);
    procedure BtNaoClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Mensagem(Texto: String; Imagem: array of TImagens);
    function Pergunta(Texto: String; Imagem: array of TImagens): boolean;
  end;

var
  FrMensagem: TFrMensagem;
  lstatus: boolean;

implementation

{$R *.dfm}
{ TFrMensagem }

procedure TFrMensagem.BtNaoClick(Sender: TObject);
begin
  lstatus := false;
  close;
end;

procedure TFrMensagem.Mensagem(Texto: String; Imagem: array of TImagens);
var
  frm: TFrMensagem;
  i: integer;

begin
  frm := TFrMensagem.Create(nil);
  frm.lbMensagem.Caption := Texto;

  frm.BtCancelar.Visible := false;
  frm.BtNao.Visible := false;
  frm.BtConfirma.Caption := 'Ok';

  for i := 0 to Length(Imagem) - 1 do
  begin
    case (Imagem[i]) of
      ImInfo:
        begin
          frm.ImInformacao.Visible := true;
          frm.ImInformacao.Align := alLeft;
        end;

      ImErro:
        begin
          frm.ImError.Visible := true;
          frm.ImError.Align := alLeft;
        end;

      ImAlert:
        begin
          frm.ImAlerta.Visible := true;
          frm.ImAlerta.Align := alLeft;
        end;
    end;
  end;

  frm.ShowModal;

end;

function TFrMensagem.Pergunta(Texto: String; Imagem: array of TImagens)
  : boolean;
var
  frm: TFrMensagem;
begin
  frm := TFrMensagem.Create(nil);
  frm.lbMensagem.Caption := Texto;
  frm.ImPergunta.Visible := true;
  frm.ImPergunta.Align := alLeft;

  frm.ShowModal;

  result := lstatus;

end;

procedure TFrMensagem.BtCancelarClick(Sender: TObject);
begin
  lstatus := false;
  close;
end;

procedure TFrMensagem.BtConfirmaClick(Sender: TObject);
begin
  lstatus := true;
  close;
end;

end.
