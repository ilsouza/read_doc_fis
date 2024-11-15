object frmDashBoard: TfrmDashBoard
  Width = 704
  Height = 489
  Caption = 'readDocFis - Dashboard'
  Color = 15790320
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnMouseMove = WebFormMouseMove
  object grdNotas: TWebDBGrid
    AlignWithMargins = True
    Left = 10
    Top = 20
    Width = 684
    Height = 459
    Margins.Left = 10
    Margins.Top = 20
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderColor = -1
    BorderStyle = bsNone
    Columns = <
      item
        Title = 'Coluna 1'
        Width = 90
      end
      item
        Title = 'Coluna 2'
        Width = 150
      end
      item
        Title = 'Coluna 3'
        Width = 150
      end
      item
        Title = 'Coluna 4'
        Width = 70
      end>
    ElementClassName = 'd-grid'
    ElementId = 'gridNotas'
    FixedCols = 1
    GridLineColor = -1
    Options = [goFixedHorzLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 0
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ColWidths = (
      24
      90
      150
      150
      70)
  end
  object grdLogAcessos: TWebDBGrid
    AlignWithMargins = True
    Left = 10
    Top = 20
    Width = 684
    Height = 459
    Margins.Left = 10
    Margins.Top = 20
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderColor = -1
    BorderStyle = bsNone
    Columns = <
      item
        Title = 'Coluna 1'
        Width = 90
      end
      item
        Title = 'Coluna 2'
        Width = 150
      end
      item
        Title = 'Coluna 3'
        Width = 150
      end
      item
        Title = 'Coluna 4'
        Width = 70
      end>
    ElementClassName = 'd-grid'
    ElementId = 'gridLogAcessos'
    FixedCols = 1
    GridLineColor = -1
    Options = [goFixedHorzLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 1
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ExplicitLeft = 122
    ExplicitTop = 44
    ColWidths = (
      24
      90
      150
      150
      70)
  end
  object gridFornecedores: TWebDBGrid
    AlignWithMargins = True
    Left = 10
    Top = 20
    Width = 684
    Height = 459
    Margins.Left = 10
    Margins.Top = 20
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderColor = -1
    BorderStyle = bsNone
    Columns = <
      item
        Title = 'Coluna 1'
        Width = 90
      end
      item
        Title = 'Coluna 2'
        Width = 150
      end
      item
        Title = 'Coluna 3'
        Width = 150
      end
      item
        Title = 'Coluna 4'
        Width = 70
      end>
    ElementClassName = 'd-grid'
    ElementId = 'gridFornecedores'
    FixedCols = 1
    GridLineColor = -1
    Options = [goFixedHorzLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    TabOrder = 2
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ExplicitLeft = 18
    ExplicitTop = 28
    ColWidths = (
      24
      90
      150
      150
      70)
  end
  object smCadastro: TWebPopupMenu
    Appearance.HamburgerMenu.Caption = 'Cadastro'
    Appearance.SubmenuIndicator = '&#9658;'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 312
    Top = 120
    object Item11: TMenuItem
      Caption = 'Item 1'
      object Subitem11: TMenuItem
        Caption = 'Sub item 1'
      end
      object Subitem12: TMenuItem
        Caption = 'Sub Item 2'
      end
    end
    object Item12: TMenuItem
      Caption = 'Item 2'
    end
    object Item31: TMenuItem
      Caption = 'Item 3'
    end
    object Item32: TMenuItem
      Caption = 'Item 4'
      object SubItem31: TMenuItem
        Caption = 'Sub Item 3'
      end
      object SubItem32: TMenuItem
        Caption = 'SubItem 4'
      end
    end
  end
  object WebElementActionList1: TWebElementActionList
    Actions = <
      item
        ID = 'menu1'
        Name = 'actRegister'
        OnExecute = WebElementActionList1Actions0Execute
      end
      item
        ID = 'menu2'
        Name = 'actEdit'
        OnExecute = WebElementActionList1Actions1Execute
      end
      item
        ID = 'menu3'
        Name = 'actFinancial'
      end
      item
        ID = 'menu4'
        Name = 'actTools'
      end
      item
        ID = 'btnSair'
        Name = 'actClose'
        OnExecute = WebElementActionList1Actions4Execute
      end>
    Left = 440
    Top = 120
  end
end
