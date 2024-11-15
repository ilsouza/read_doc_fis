unit FLogin;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.Actions, XData.Web.Client, WEBLib.REST,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls, Weblib.JSON;

type
  TfrmLogin = class(TWebForm)
    WebElementActionList1: TWebElementActionList;
    procedure WebFormCreate(Sender: TObject);
    procedure WebElementActionList1Actions0Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions1Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions2Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions3Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
    procedure WebElementActionList1Actions4Execute(Sender: TObject; Element:
        TJSHTMLElementRecord; Event: TJSEventParameter);
  private
    { Private declarations }
    procedure CallDashBoardForm; async;
    procedure CallSignUpForm; async;
  public
    edtLogin: TWebEdit;
    edtPwd: TWebEdit;
    reqLogin: TWebHttpRequest;
    edtTk: TWebEdit;
    WebButton1: TWebButton;
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses FSignUp, UwebDM, SweetAlerts, FDashBoard;

procedure TfrmLogin.WebFormCreate(Sender: TObject);
begin
  if (webDM = nil) then
  begin
    Application.CreateForm(TwebDM, webDM);
  end;
end;

procedure TfrmLogin.WebElementActionList1Actions0Execute(Sender: TObject;
                    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
var
  jLoginData : TJSONObject;
  LLogin, LPwd, LToken : String;
begin
  LLogin := ''; LPwd := ''; LToken := '';

  LLogin := edtLogin.Text;
  LPwd   := edtPwd.Text;
  LToken := edtTk.Text;

  if (LLogin.IsEmpty or LPwd.IsEmpty) then
  begin
    MessageJS('Dados incompletos', 'Informe usuário & senha', gERROR);
    exit;
  end;

  reqLogin.URL      := '';
  reqLogin.PostData := '';

  reqLogin.Headers.Clear;
  reqLogin.Headers.Add('Cache-Control=no-cache, no-store, must-revalidate');
  reqLogin.Headers.Add('Content-Type=application/json');

  if not SameText(edtTk.Text, '') then
  begin
    TOKEN := edttk.Text;
  end;

  // Send token if present
  if not SameText(TOKEN, '') then
  begin
    reqLogin.Headers.Values['Authorization'] := 'bearer ' + TOKEN;
  end;

  reqLogin.Command := httpPOST;
  reqLogin.URL     := URL_SERVER + '/loginService/GetLogin';

  jLoginData := TJSONObject.Create;

  try
    jLoginData.AddPair('sUser', LLogin);
    jLoginData.AddPair('sPassword', LPwd);

    reqLogin.PostData := jLoginData.ToString;
  finally
    jLoginData.Free;
  end;

  reqLogin.Execute(
    procedure(AResponse: String; AReq: TJSXMLHttpRequest)
    var
      js : TJSON;
      jResponse, jValue : TJSONObject;
      LCode, LMessage : String;
    begin
      js := TJSON.Create;

      if ((AReq.Status >= 400) or (AReq.Status = 500)) then
      begin
        jResponse := (js.Parse(AResponse) as TJSONObject);
        jValue    := jResponse.GetValue('error') as TJSONObject;

        LCode    := jValue.GetJSONValue('code');
        LMessage := jValue.GetJSONValue('message');

        MessageJS('Status: ' + AReq.Status.ToString, LMessage, gError);
        Exit;
      end;

      jResponse := (js.Parse(AResponse) as TJSONObject);
      jValue    := jResponse.GetValue('value') as TJSONObject;

      if (TOKEN = '') then
      begin
        TOKEN := jValue.GetJSONValue('token');
        WebButton1.Caption := 'Login';

        MessageJS('Token de Autenticação', TOKEN, gINFO);
        edtTk.Text := TOKEN;
      end
        else
        begin
          edtTk.Text := '';
          edtTk.Text := 'Get Token';
          CallDashBoardForm;
        end;
    end
  );
end;

procedure TfrmLogin.WebElementActionList1Actions1Execute(Sender: TObject;
                    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  CallSignUpForm;
end;

procedure TfrmLogin.WebElementActionList1Actions2Execute(Sender: TObject;
                    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  CallSignUpForm;
end;

procedure TfrmLogin.CallDashBoardForm; async;
var
  LDashBoard : TfrmDashBoard;
  LResult : Integer;
begin
  LDashBoard := TfrmDashBoard.Create(Self);
  LDashBoard.Popup := False;

  try
    await(TfrmDashBoard, LDashBoard.Load);
    LResult := await(TModalResult, LDashBoard.Execute);

    if (LResult = mrOk) then
    begin
      ShowMessage('Main form loaded');
    end;
  finally
    LDashBoard.Free;
    document.location.reload(true);
  end;
end;

procedure TfrmLogin.CallSignUpForm; async;
var
  LFormSignUp : TfrmSignUp;
  LResult : Integer;
begin
  LFormSignUp := TfrmSignUp.Create(Self);
  LFormSignUp.Popup := False;

  try
    await(TfrmSignUp, LFormSignUp.Load);
    LResult := await(TModalResult, LFormSignUp.Execute);

    if (LResult = mrOk) then
    begin
      ShowMessage('SignUp form loaded');
    end;
  finally
    LFormSignUp.Free;
  end;
end;

procedure TfrmLogin.WebElementActionList1Actions3Execute(Sender: TObject;
    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  MessageJS('Título da janela', 'Texto da janela', gSUCCESS);
end;

procedure TfrmLogin.WebElementActionList1Actions4Execute(Sender: TObject;
    Element: TJSHTMLElementRecord; Event: TJSEventParameter);
begin
  try
    MessageDialogJS('Título da Mensagem', 'Texto da mensagem', gWARNING, 'Sim', 'Não');
  finally
(*
    if MESSAGE_RESULT then
    begin
      MessageJS('Título da janela', 'Texto da janela', gSUCCESS);
    end
      else
      begin
        MessageJS('Título da janela', 'Texto da janela', gERROR);
      end;
*)
  end;
end;

end.
