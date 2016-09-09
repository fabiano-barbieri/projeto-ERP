inherited fGridBanco: TfGridBanco
  Caption = 'Bancos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    inherited Botao_Exit: TBitBtn
      Left = 794
      ExplicitLeft = 794
    end
  end
  inherited pnlGrid: TPanel
    inherited pnlCampos: TPanel
      Anchors = [akLeft]
    end
  end
  inherited qryGrid: TSQLQuery
    MaxBlobSize = -1
  end
end
