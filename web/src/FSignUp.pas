unit FSignUp;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.Actions;

type
  TfrmSignUp = class(TWebForm)
    WebElementActionList1: TWebElementActionList;
    procedure WebElementActionList1Actions0Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions1Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

uses FLogin;

procedure TfrmSignUp.WebElementActionList1Actions0Execute(Sender: TObject;
    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  Application.CreateForm(TfrmLogin, frmLogin);
end;

procedure TfrmSignUp.WebElementActionList1Actions1Execute(Sender: TObject;
    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  Application.CreateForm(TfrmLogin, frmLogin);
end;

end.