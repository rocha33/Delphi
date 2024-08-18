object frmBase: TfrmBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'frmBase'
  ClientHeight = 157
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object stbHora: TStatusBar
    Left = 0
    Top = 138
    Width = 475
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end>
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 64
    Top = 24
  end
end
