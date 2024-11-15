unit loginServiceImplementation;

interface

uses
  System.Classes, System.SysUtils, System.Variants, JSON,
  FireDAC.Stan.Intf, FireDAC.Comp.Client,

  XData.Server.Module,
  XData.Service.Common,
  XData.Sys.Exceptions,
  XData.OpenApi.Service,
  XData.SwaggerUI.Service,

  Bcl.Jose.Core.JWT, Bcl.Jose.Core.Builder,

  Sparkle.Middleware.Jwt,
  Aurelius.Mapping.Metadata,

  loginService, UCrypt, USendMail;

type
  [ServiceImplementation]
  TloginService = class(TInterfacedObject, IloginService)
  private
    function GetLogin(aUserID, aPassword : string) : TJsonObject;
    function GetToken(sIDToken : string) : TJsonObject;
  end;

implementation

uses
  ConnectionModule, XData.Client, UEntities, XData.Module.Events;

function TloginService.GetLogin(aUserID, aPassword: string): TJsonObject;
var
  xConModulePG : TConnectionModulePG;
  ClientDoc    : TXDataClient;
  // XDataServerModule : TXDataServerModule;

  USUARIO : Tusuario;
  TOKEN   : Ttoken;

  Ljwt : TJWT;
  LChave_Token : string;
  LEmail_User  : string;

  LObject, LPair : TJSONObject;
  LToken : string;

  SendMail  : TSendMailThread;
  LMessage  : TStringList;
  LAgora    : TDateTime;
  LAgoraStr : String;
begin
  xConModulePG := TConnectionModulePG.Create(nil);

  ClientDoc     := TXDataClient.Create;
  ClientDoc.Uri := URL_SERVER;

  LObject := TJSONObject.Create(nil);
  LPair   := TJSONObject.Create(nil);

  USUARIO := xConModulePG.auManager.Find<Tusuario>(aUserID);

  if (USUARIO.usr_password <> aPassword) then
  begin
    LPair.AddPair('error', 'Invalid login information');
    LObject.AddPair('value', LPair);

    Result := LObject;

    xConModulePG.DisposeOf;
    //ClientDoc.DisposeOf;
    USUARIO.DisposeOf;

    raise EXDataException.Create('Unauthorized');
  end;

  try
    LAgora := now;

    {Generate the token}
    Ljwt := TJWT.Create(TJWTClaims);

    try
      Ljwt.Claims.jwtid := JWT_SECRET;
      Ljwt.Claims.SetClaimOfType<string>('username', aUserID);
      Ljwt.Claims.SetClaimOfType<string>('password', aPassword);
      Ljwt.Claims.SetClaimOfType<boolean>('isadmin', true);

      Ljwt.Claims.Issuer := 'ReadDocFis';
      LToken := TJOSE.SHA256CompactToken(JWT_SECRET, Ljwt);

      LAgoraStr := DateTimeToStr(LAgora);
      LChave_Token := Crypt('C', LAgoraStr);

      LEmail_User := USUARIO.usr_email;
    finally
      Ljwt.DisposeOf;
    end;

    LObject := TJSONObject.Create(nil);
    LPair   := TJSONObject.Create(nil);

    // Grava Token na base
    TOKEN := Ttoken.Create;

    try
      TOKEN.tok_token       := LToken;
      TOKEN.tok_data_hora   := LAgora;
      TOKEN.tok_password    := aPassword;
      TOKEN.tok_duracao_seg := 14400; {4 horas}
      TOKEN.tok_chave       := LChave_Token;
      TOKEN.fk_emp          := USUARIO.fk_emp;
      TOKEN.fk_usr          := USUARIO;

      ClientDoc.Post(TOKEN);
    finally
      TOKEN.DisposeOf;
    end;

    // Envia Chave (LChave) para o email do usuário
    LMessage := TStringList.Create;

    try
      LMessage.Add('<html><head><meta http-equiv="content-type" content="text/html; charset=UTF-8"></head>');
      LMessage.Add('<body text="#000000" bgcolor="#FFFFFF">');
      LMessage.Add('<h1>Informe token abaixo:</h1>');
      LMessage.Add('<p>' + LChave_Token + ':</p><br>');
 //     LMessage.Add('<img src=' + QuotedStr('cid:LogoACBr') + '>');
      LMessage.Add('</body></html>');

      try
        SendMail.EnviarEmail('help@qualicodex.com', LEmail_User, 'Token',
                             LMessage, True, nil, nil, False, False, 'ReadDocFis', True);
      except
        on e: exception do
        begin
          raise EXDataException.Create(e.Message);
        end;
      end;
    finally
      LMessage.DisposeOf;
      //SendMail.DisposeOf;
    end;

    LPair.AddPair('token', 'verifique seu email');  // LToken
    LObject.AddPair('value', LPair);

    xConModulePG.DisposeOf;
    //USUARIO.DisposeOf;
    ClientDoc.DisposeOf;
  except
    on e : exception do
    begin
      LPair.AddPair('token', 'verifique seu email');  // LToken
      LObject.AddPair('value', e.Message);
    end;
  end;

  Result := LObject;
end;

function TloginService.GetToken(sIDToken: string): TJsonObject;
var
  xConModulePG : TConnectionModulePG;
  ClientDoc    : TXDataClient;
  // XDataServerModule : TXDataServerModule;

  TOKEN   : Ttoken;

  Ljwt : TJWT;
  LChave_Token : string;
  LEmail_User  : string;

  LObject, LPair : TJSONObject;
  LToken : string;

  SendMail  : TSendMailThread;
  LMessage  : TStringList;
  LAgora    : TDateTime;
  LAgoraStr : String;
begin
  xConModulePG := TConnectionModulePG.Create(nil);

  ClientDoc     := TXDataClient.Create;
  ClientDoc.Uri := URL_SERVER;

  LObject := TJSONObject.Create(nil);
  LPair   := TJSONObject.Create(nil);

  TOKEN := xConModulePG.auManager.Find<Ttoken>(sIDToken);
(*
  if (TOKEN.tok_password <> aPassword) then
  begin
    LPair.AddPair('error', 'Invalid login information');
    LObject.AddPair('value', LPair);

    Result := LObject;

    xConModulePG.DisposeOf;
    //ClientDoc.DisposeOf;
    USUARIO.DisposeOf;

    raise EXDataException.Create('Unauthorized');
  end;
*)
  try
    LAgora := now;

    {Generate the token}
    Ljwt := TJWT.Create(TJWTClaims);

    try
      Ljwt.Claims.jwtid := JWT_SECRET;
      Ljwt.Claims.SetClaimOfType<string>('username', aUserID);
      Ljwt.Claims.SetClaimOfType<string>('password', aPassword);
      Ljwt.Claims.SetClaimOfType<boolean>('isadmin', true);

      Ljwt.Claims.Issuer := 'ReadDocFis';
      LToken := TJOSE.SHA256CompactToken(JWT_SECRET, Ljwt);

      LAgoraStr := DateTimeToStr(LAgora);
      LChave_Token := Crypt('C', LAgoraStr);

      LEmail_User := USUARIO.usr_email;
    finally
      Ljwt.DisposeOf;
    end;

    LObject := TJSONObject.Create(nil);
    LPair   := TJSONObject.Create(nil);

    // Grava Token na base
    TOKEN := Ttoken.Create;

    try
      TOKEN.tok_token       := LToken;
      TOKEN.tok_data_hora   := LAgora;
      TOKEN.tok_password    := aPassword;
      TOKEN.tok_duracao_seg := 14400; {4 horas}
      TOKEN.tok_chave       := LChave_Token;
      TOKEN.fk_emp          := USUARIO.fk_emp;
      TOKEN.fk_usr          := USUARIO;

      ClientDoc.Post(TOKEN);
    finally
      TOKEN.DisposeOf;
    end;

    // Envia Chave (LChave) para o email do usuário
    LMessage := TStringList.Create;

    try
      LMessage.Add('<html><head><meta http-equiv="content-type" content="text/html; charset=UTF-8"></head>');
      LMessage.Add('<body text="#000000" bgcolor="#FFFFFF">');
      LMessage.Add('<h1>Informe token abaixo:</h1>');
      LMessage.Add('<p>' + LChave_Token + ':</p><br>');
 //     LMessage.Add('<img src=' + QuotedStr('cid:LogoACBr') + '>');
      LMessage.Add('</body></html>');

      try
        SendMail.EnviarEmail('help@qualicodex.com', LEmail_User, 'Token',
                             LMessage, True, nil, nil, False, False, 'ReadDocFis', True);
      except
        on e: exception do
        begin
          raise EXDataException.Create(e.Message);
        end;
      end;
    finally
      LMessage.DisposeOf;
      //SendMail.DisposeOf;
    end;

    LPair.AddPair('token', 'verifique seu email');  // LToken
    LObject.AddPair('value', LPair);

    xConModulePG.DisposeOf;
    //USUARIO.DisposeOf;
    ClientDoc.DisposeOf;
  except
    on e : exception do
    begin
      LPair.AddPair('token', 'verifique seu email');  // LToken
      LObject.AddPair('value', e.Message);
    end;
  end;

  Result := LObject;
end;

initialization
  RegisterServiceType(TloginService);

  {$IFDEF DOCFIS_CONSOLE}
    RegisterOpenAPIService;
    RegisterSwaggerUIService;
  {$ENDIF}

end.
