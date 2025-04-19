object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 446
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnIncluir: TButton
    Left = 232
    Top = 8
    Width = 121
    Height = 25
    Hint = 
      'Criar uma funcionalidade para inserir 5 novos clientes. '#13#10'Criar ' +
      'uma funcionalidade para inserir 5 modelos de carros novos. '#13#10'ins' +
      'ere uma venda para os 5 novos clientes'
    Caption = 'Incluir'
    TabOrder = 0
    OnClick = btnIncluirClick
  end
end
