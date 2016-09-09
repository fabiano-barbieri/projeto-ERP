inherited fCadBanco: TfCadBanco
  Caption = 'Cadastro de Bancos'
  ClientHeight = 202
  ClientWidth = 421
  ExplicitWidth = 437
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited sbMSG: TStatusBar
    Top = 177
    Width = 421
    ExplicitTop = 177
    ExplicitWidth = 421
  end
  inherited pnlBotoes: TPanel
    Top = 137
    Width = 421
    ExplicitTop = 137
    ExplicitWidth = 421
    inherited Botao_Cancelar: TBitBtn
      Left = 307
      ExplicitLeft = 307
    end
    inherited Botao_Ok: TBitBtn
      Left = 214
      ExplicitLeft = 214
    end
  end
  inherited pnlDados: TPanel
    Width = 421
    Height = 137
    ExplicitWidth = 421
    ExplicitHeight = 137
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 52
      Height = 13
      Caption = 'ID_BANCO'
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 63
      Height = 13
      Caption = 'COD_BANCO'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 8
      Top = 88
      Width = 35
      Height = 13
      Caption = 'BANCO'
      FocusControl = DBEdit3
    end
    object DBEdit1: TDBEdit
      Left = 8
      Top = 24
      Width = 52
      Height = 21
      DataField = 'ID_BANCO'
      DataSource = dsoCad
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 8
      Top = 64
      Width = 63
      Height = 21
      DataField = 'COD_BANCO'
      DataSource = dsoCad
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 8
      Top = 104
      Width = 394
      Height = 21
      DataField = 'BANCO'
      DataSource = dsoCad
      TabOrder = 2
    end
  end
  inherited dsoCad: TDataSource
    Left = 232
    Top = 24
  end
  inherited qryCad: TSQLQuery
    SQL.Strings = (
      'select * from tb_banco')
    SQLConnection = dmodule.conexao
    Left = 200
    Top = 24
    object qryCadID_BANCO: TIntegerField
      FieldName = 'ID_BANCO'
      Required = True
    end
    object qryCadCOD_BANCO: TIntegerField
      FieldName = 'COD_BANCO'
      Required = True
    end
    object qryCadBANCO: TStringField
      FieldName = 'BANCO'
      Required = True
      Size = 30
    end
  end
  inherited cdsCad: TClientDataSet
    Left = 264
    Top = 24
    object cdsCadID_BANCO: TIntegerField
      FieldName = 'ID_BANCO'
      Required = True
    end
    object cdsCadCOD_BANCO: TIntegerField
      FieldName = 'COD_BANCO'
      Required = True
    end
    object cdsCadBANCO: TStringField
      FieldName = 'BANCO'
      Required = True
      Size = 30
    end
  end
  inherited dspCad: TDataSetProvider
    Left = 296
    Top = 24
  end
end
