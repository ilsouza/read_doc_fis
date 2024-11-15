object frmLogin: TfrmLogin
  Width = 640
  Height = 480
  Caption = 'readDocFis - Login'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  OnCreate = WebFormCreate
  object edtLogin: TWebEdit
    Left = 304
    Top = 184
    Width = 121
    Height = 22
    ElementClassName = 'form-control'
    ElementID = 'edtUser'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = '1'
    WidthPercent = 100.000000000000000000
  end
  object edtPwd: TWebEdit
    Left = 304
    Top = 224
    Width = 121
    Height = 22
    ChildOrder = 1
    ElementClassName = 'form-control'
    ElementID = 'edtPassword'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Text = '1'
    WidthPercent = 100.000000000000000000
  end
  object edtTk: TWebEdit
    Left = 304
    Top = 264
    Width = 121
    Height = 22
    ChildOrder = 1
    ElementClassName = 'form-control'
    ElementID = 'edtToken'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object WebButton1: TWebButton
    Left = 368
    Top = 336
    Width = 169
    Height = 33
    Caption = 'Get Token'
    ChildOrder = 3
    ElementClassName = 'btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0'
    ElementID = 'btnLogin'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object WebElementActionList1: TWebElementActionList
    Actions = <
      item
        ID = 'btnLogin'
        Name = 'actLogin'
        OnExecute = WebElementActionList1Actions0Execute
      end
      item
        ID = 'btnSignUp'
        Name = 'actSignUp'
        OnExecute = WebElementActionList1Actions1Execute
      end
      item
        ID = 'btnSignUp2'
        Name = 'atSignUp2'
        OnExecute = WebElementActionList1Actions2Execute
      end
      item
        ID = 'btnDashboard'
        Name = 'Action3'
        OnExecute = WebElementActionList1Actions3Execute
      end
      item
        ID = 'btnPerfil'
        Name = 'Action4'
        OnExecute = WebElementActionList1Actions4Execute
      end>
    Left = 504
    Top = 48
  end
  object reqLogin: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    ResponseType = rtText
    Left = 504
    Top = 112
  end
end
