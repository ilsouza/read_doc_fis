object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'XData Server - main form'
  ClientHeight = 311
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object panTop: TPanel
    Left = 0
    Top = 0
    Width = 566
    Height = 41
    Align = alTop
    TabOrder = 0
    object lblStatus: TLabel
      Left = 1
      Top = 1
      Width = 564
      Height = 39
      Align = alClient
      Alignment = taCenter
      Caption = 'Server STOPED'
      Layout = tlCenter
      ExplicitWidth = 76
      ExplicitHeight = 15
    end
  end
  object panBottom: TPanel
    Left = 0
    Top = 270
    Width = 566
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnConnect: TButton
      Left = 400
      Top = 1
      Width = 165
      Height = 39
      Align = alRight
      Caption = 'STOP'
      TabOrder = 0
      OnClick = btnConnectClick
    end
  end
  object panLog: TPanel
    Left = 0
    Top = 41
    Width = 566
    Height = 229
    Align = alClient
    TabOrder = 2
    object memLog: TMemo
      Left = 1
      Top = 1
      Width = 564
      Height = 227
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
end
