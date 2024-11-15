unit FDashBoard;

interface

uses
  System.SysUtils, System.Classes,
  JS, Web, WEBLib.Graphics, WEBLib.Controls, WEBLib.Forms, WEBLib.Dialogs, Vcl.Menus,
  WEBLib.Menus, Vcl.Controls, WEBLib.WebCtrls, WEBLib.StdCtrls, WEBLib.ExtCtrls,
  WEBLib.Actions, WEBLib.JQCtrls,

  Vcl.StdCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions, VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl,
  VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, VCL.TMSFNCHTMLText, VCL.TMSFNCLabelEdit,
  VCL.TMSFNCEdit, Vcl.Grids, WEBLib.DBCtrls, WEBLib.Grids;

type
  TfrmDashBoard = class(TWebForm)
    smCadastro: TWebPopupMenu;
    Item11: TMenuItem;
    Item12: TMenuItem;
    Item31: TMenuItem;
    Item32: TMenuItem;
    Subitem11: TMenuItem;
    Subitem12: TMenuItem;
    SubItem31: TMenuItem;
    SubItem32: TMenuItem;
    WebElementActionList1: TWebElementActionList;
    grdNotas: TWebDBGrid;
    grdLogAcessos: TWebDBGrid;
    gridFornecedores: TWebDBGrid;
    procedure WebElementActionList1Actions0Execute(Sender: TObject; Element:
              TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions1Execute(Sender: TObject; Element:
              TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions4Execute(Sender: TObject; Element:
              TJSHTMLElementRecord; Event: TJSEventParameter);

    procedure WebFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    procedure RealinhaGrid;
    { Private declarations }
  public
    { Public declarations }
    pX, pY : integer;
  end;

var
  frmDashBoard: TfrmDashBoard;

implementation

{$R *.dfm}

procedure TfrmDashBoard.WebElementActionList1Actions0Execute(Sender: TObject;
                   Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  smCadastro.Popup(pX-30, pY+30);
end;

procedure TfrmDashBoard.WebElementActionList1Actions1Execute(Sender: TObject;
                   Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  smCadastro.Popup(pX-30, pY+30);
end;

procedure TfrmDashBoard.WebElementActionList1Actions4Execute(Sender: TObject;
                   Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  Close;
end;

procedure TfrmDashBoard.WebFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  pX := X;
  pY := Y;
end;

procedure TfrmDashBoard.RealinhaGrid;
var
  el, el_Sub : TJSElement;
  at_Pos, at_Value : TJSAttr;
  sHTML : WideString;
begin
  el     := document.getElementById('TfrmDashBoard_TMSFNCGrid2');
  el_Sub := document.getElementById(el.id);

(*
  sHTML := '<span id="TfrmDashBoard_TMSFNCGrid2" zindex="0" tabindex="1" role="" style="color: rgb(0, 0, 0); ' +
           'overflow: hidden; outline: none; top: 70px; left: 20px; width: 750px; height: 241px; position: ' +
           'absolute; box-sizing: border-box; user-select: none; -webkit-tap-highlight-color: transparent; ' +
           'background-color: rgb(255, 255, 255); font-family: Arial; font-style: normal; font-size: 8pt;">' +
           '<canvas id="TfrmDashBoard_TMSFNCGrid2_Canvas" zindex="-1" height="241" width="553" ' +
           'style="position: absolute; height: 241px; width: 553px;"></canvas></span>';
*)

//  el_Sub.outerHTML := sHTML;

  sHTML := 'color: rgb(0, 0, 0); overflow: hidden; outline: none; top: 70px; left: 20px; width: 750px; ' +
           'height: 241px; box-sizing: border-box; user-select: none; ' +
           '-webkit-tap-highlight-color: transparent; background-color: rgb(255, 255, 255); ' +
           'font-family: Arial; font-style: normal; font-size: 8pt;';

  el_Sub.setAttribute('style', sHTML);
end;

end.
