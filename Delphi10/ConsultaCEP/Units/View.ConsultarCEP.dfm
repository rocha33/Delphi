inherited frmConsultarCEP: TfrmConsultarCEP
  Caption = 'Consultar CEP'
  ClientHeight = 593
  ClientWidth = 793
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 809
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 15
  inherited stbHora: TStatusBar
    Top = 574
    Width = 793
    ExplicitTop = 574
    ExplicitWidth = 793
  end
  object rdgMetodo: TRadioGroup [1]
    Left = 320
    Top = 6
    Width = 130
    Height = 45
    Caption = 'M'#233'todo de Consulta'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'JSON'
      'XML')
    ParentFont = False
    TabOrder = 2
  end
  object GroupBox1: TGroupBox [2]
    Left = 0
    Top = 232
    Width = 793
    Height = 342
    Align = alBottom
    Caption = 'Cep Cadastrados'
    TabOrder = 3
    object dbgCepCadastrados: TDBGrid
      Left = 2
      Top = 17
      Width = 789
      Height = 323
      Align = alClient
      DataSource = dsCEPCadastrado
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbgCepCadastradosCellClick
      OnDblClick = dbgCepCadastradosDblClick
    end
  end
  object GroupBox2: TGroupBox [3]
    Left = 320
    Top = 49
    Width = 468
    Height = 174
    Caption = 'Retorno Consulta Cep'
    TabOrder = 4
    object dbgRetornoConsulta: TDBGrid
      Left = 2
      Top = 17
      Width = 462
      Height = 121
      DataSource = dsRetornoConsulta
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = dbgRetornoConsultaDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cep'
          Title.Caption = 'Cep'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'logradouro'
          Title.Caption = 'Logradouro'
          Width = 190
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bairro'
          Title.Caption = 'Bairro'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'localidade'
          Title.Caption = 'Localidade'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Title.Caption = 'UF'
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ibge'
          Title.Caption = 'IBGE'
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'complemento'
          Title.Caption = 'Complemento'
          Width = 133
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'gia'
          Title.Caption = 'Gia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unidade'
          Title.Caption = 'Unidade'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ddd'
          Title.Caption = 'DDD'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'siafi'
          Title.Caption = 'Siafi'
          Visible = True
        end>
    end
    object btnSalvar: TBitBtn
      Left = 382
      Top = 144
      Width = 81
      Height = 25
      Caption = 'Salvar'
      Glyph.Data = {
        B2050000424DB205000000000000360400002800000012000000130000000100
        0800000000007C010000130B0000130B00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F7F7A4A4A49B
        9B9B9B9B9B9B9B9BA4A4A4F600004949005252F7F7F7F7F7F7F7F7F7000000F7
        00004949005252F7F7F7F7F7F7F7F7F7000000F70000525200F7F7FFFFFFFFFF
        FFFFFFFF000000F70000525200ADADFFFFFFFFFFFFFFFFFF000000F700005252
        00ADADFFFFFFFFFFFFFFFFFF000000F70000525200F7F7FFFFFFFFFFFFFFFFFF
        000000F70000525200525207F7F7F7F7F7F7F7F7000000F70000525200525207
        F7F7F7F7F7F7F7F7000000F700005252000000000000000000000000000000F7
        00005252000000000000000000000000000000F7000052520000000000000000
        00000000000000F70000525200000008F6F6F6F7F7A49B9B000000F700005252
        000000F6FFFFFF9B9B00A4A4000000F700005252000000F6FFFFFF9B9B00A4A4
        000000F700005252000000F6FFFFFF9B9B00A4A40000000700005252000000F6
        FFFFFFF7F7A49B9B00A4A4FF00005252000000F6FFFFFFF7F7A49B9B00A4A4FF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
      TabOrder = 1
      OnClick = btnSalvarClick
    end
  end
  object btnPesquisa: TBitBtn [4]
    Left = 684
    Top = 8
    Width = 101
    Height = 38
    Caption = 'Pesquisar'
    Glyph.Data = {
      F2060000424DF206000000000000360400002800000019000000190000000100
      080000000000BC020000C40E0000C40E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFE1D0FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFE1D8EBFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE1D8F3FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1D8EA
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9D8EBFFFFFFFF00
      0000FFFFFFFFFFFFFFFF080707F6FFFFFFFFFFE9D8F3FFFFFFFFFF000000FFFF
      FFFFFFF6A452525252525207FFFFE9D8F3FFFFFFFFFFFF000000FFFFFFFFF752
      5B07F6F6F608F7529C07D8F3FFFFFFFFFFFFFF000000FFFFFF0749F7FFFFFFFF
      FFFFFFF6520AF6FFFFFFFFFFFFFFFF000000FFFFF64907FFFFFFFFFFFFFFFFFF
      FF9BA4FFFFFFFFFFFFFFFF000000FFFF52A4FFFFFFFFFFFFFFFFFFFFFFFF4907
      FFFFFFFFFFFFFF000000FFF649F6FFFFFFFFFFFFFFFFFFFFFFFFA452FFFFFFFF
      FFFFFF000000FFF75BFFFFFFFFFFFFFFFFFFFFFFFFFF0852F6FFFFFFFFFFFF00
      0000FF9BA4FFFFFFFFFFFFFFFFFFFFFFFFFFF65208FFFFFFFFFFFF000000FF5B
      A4FFFFFFFFFFFFFFFFFFFFFFFFFFF65208FFFFFFFFFFFF000000FFA49BFFFFFF
      FFFFFFFFFFFFFFFFFFFFF652F6FFFFFFFFFFFF000000FF0852FFFFFFFFFFFFFF
      FFFFFFFFFFFF0752FFFFFFFFFFFFFF000000FFFF5207FFFFFFFFFFFFFFFFFFFF
      FFFF52F7FFFFFFFFFFFFFF000000FFFFF749FFFFFFFFFFFFFFFFFFFFFFF752FF
      FFFFFFFFFFFFFF000000FFFFFF9B52F6FFFFFFFFFFFFFFFFF70008FFFFFFFFFF
      FFFFFF000000FFFFFFFF5B52F7F6FFFFFFFF089B4907FFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFF752525B9B9B52525BF6FFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFF08F7A4A407F6FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    TabOrder = 0
    OnClick = btnPesquisaClick
  end
  object rdgCepLogradouro: TRadioGroup [5]
    Left = 453
    Top = 7
    Width = 224
    Height = 45
    Caption = 'Pesquisar por:'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'CEP'
      'LOGRADOURO')
    ParentFont = False
    TabOrder = 5
  end
  object Panel1: TPanel [6]
    Left = 4
    Top = 6
    Width = 313
    Height = 219
    TabOrder = 6
    object lblCep: TLabel
      Left = 62
      Top = 12
      Width = 20
      Height = 15
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblComplemento: TLabel
      Left = 4
      Top = 70
      Width = 79
      Height = 15
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLogradouro: TLabel
      Left = 19
      Top = 41
      Width = 64
      Height = 15
      Caption = 'Logradouro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblBairro: TLabel
      Left = 49
      Top = 101
      Width = 34
      Height = 15
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCidade: TLabel
      Left = 45
      Top = 130
      Width = 37
      Height = 15
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUf: TLabel
      Left = 68
      Top = 159
      Width = 15
      Height = 15
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCEP: TEdit
      Left = 92
      Top = 9
      Width = 217
      Height = 23
      TabOrder = 0
      Text = '83600970'
      OnEnter = edtCEPEnter
    end
    object edtComplemento: TEdit
      Left = 92
      Top = 67
      Width = 217
      Height = 23
      TabOrder = 2
    end
    object edtLogradouro: TEdit
      Left = 92
      Top = 38
      Width = 217
      Height = 23
      TabOrder = 1
      OnEnter = edtLogradouroEnter
    end
    object edtBairro: TEdit
      Left = 92
      Top = 98
      Width = 217
      Height = 23
      TabOrder = 3
    end
    object edtLocalidade: TEdit
      Left = 92
      Top = 127
      Width = 217
      Height = 23
      TabOrder = 4
    end
    object edtUf: TEdit
      Left = 91
      Top = 156
      Width = 218
      Height = 23
      MaxLength = 2
      TabOrder = 5
    end
  end
  inherited Timer1: TTimer
    Left = 808
    Top = 16
  end
  object dsCEPCadastrado: TDataSource
    DataSet = fdCepCadastrado
    Left = 480
    Top = 424
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = fdTempConsulta
    FieldDefs = <>
    Left = 601
    Top = 377
  end
  object fdTempConsulta: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 528
    Top = 248
    object fdTempConsultacep: TWideStringField
      FieldName = 'cep'
      Size = 9
    end
    object fdTempConsultalogradouro: TWideStringField
      FieldName = 'logradouro'
      Size = 100
    end
    object fdTempConsultacomplemento: TWideStringField
      FieldName = 'complemento'
      Size = 50
    end
    object fdTempConsultaunidade: TWideStringField
      FieldName = 'unidade'
      Size = 0
    end
    object fdTempConsultabairro: TWideStringField
      FieldName = 'bairro'
      Size = 50
    end
    object fdTempConsultalocalidade: TWideStringField
      FieldName = 'localidade'
      Size = 50
    end
    object fdTempConsultauf: TWideStringField
      FieldName = 'uf'
      Size = 2
    end
    object fdTempConsultaibge: TIntegerField
      FieldName = 'ibge'
    end
    object fdTempConsultagia: TIntegerField
      FieldName = 'gia'
    end
    object fdTempConsultaddd: TIntegerField
      FieldName = 'ddd'
    end
    object fdTempConsultasiafi: TIntegerField
      FieldName = 'siafi'
    end
  end
  object fdCepCadastrado: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    Left = 400
    Top = 408
  end
  object dsRetornoConsulta: TDataSource
    DataSet = fdTempConsulta
    Left = 632
    Top = 242
  end
  object XMLDocument1: TXMLDocument
    Left = 696
    Top = 488
    DOMVendorDesc = 'MSXML'
  end
  object SSLIO: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 696
    Top = 440
  end
end