object frmSignUp: TfrmSignUp
  Width = 640
  Height = 480
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  object WebElementActionList1: TWebElementActionList
    Actions = <
      item
        ID = 'btnLogin1'
        Name = 'actLogin1'
        OnExecute = WebElementActionList1Actions0Execute
      end
      item
        ID = 'btnLogin2'
        Name = 'actLogin2'
        OnExecute = WebElementActionList1Actions1Execute
      end>
    Left = 464
    Top = 112
  end
end
