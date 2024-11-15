unit USendMail;

interface

uses SysUtils, Types, IniFiles, Classes, smtpsend, ssl_openssl, mimemess, mimepart, Contnrs;

type
  TSendMailThread = class(TThread)
  private
    FException : Exception;

    procedure DoHandleException;
  public
    Terminado : Boolean;
    smtp      : TSMTPSend;
    sFrom     : String;
    sTo       : String;

    sCC         : TStrings;
    slmsg_Lines : TStrings;

    constructor Create(AOwner : TComponent);
    Destructor Destroy; override ;

    function RetornaDadosProvedor(AChave, AValue : string) : string;
    function EnviarEmail(const sFrom, sTo, sAssunto: String;
                         sMensagem : TStrings;
                         SSL       : Boolean;
                         sCC       : TStrings = nil;
                         Anexos    : TStrings = nil;

                         PedeConfirma  : Boolean = False;
                         AguardarEnvio : Boolean = False;
                         NomeRemetente : String  = '';
                         TLS           : Boolean = True) : boolean;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;

implementation

uses
  Web.WebBroker, synachar;

function TSendMailThread.RetornaDadosProvedor(AChave, AValue : string) : string;
var
  cPath : string;
begin
  Result := '';

  if SameText(AChave, 'SMTP') then
  begin
    if SameText(AValue, 'ServidorSMTP') then Result := 'mail.qualicodex.com';
    if SameText(AValue, 'PortaSMTP')    then Result := '465';
    if SameText(AValue, 'LoginSMTP')    then Result := 'help@qualicodex.com';
    if SameText(AValue, 'SenhaSMTP')    then Result := 'helpQualicodex2023#';
  end;
end;

constructor TSendMailThread.Create(AOwner : TComponent);
begin
  smtp        := TSMTPSend.Create;
  slmsg_Lines := TStringList.Create;
  sCC         := TStringList.Create;
  sFrom       := '';
  sTo         := '';

  FreeOnTerminate := True;

  inherited Create(True);
end;

destructor TSendMailThread.Destroy;
begin
  slmsg_Lines.Free;
  sCC.Free;
  smtp.Free;

  inherited;
end;

procedure TSendMailThread.Execute;
var
  I: integer;
begin
   inherited;

   try
     Terminado := False;

     try
       if not smtp.Login() then
         raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

       if not smtp.MailFrom( sFrom, Length(sFrom)) then
         raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

       if not smtp.MailTo(sTo) then
         raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

       if (sCC <> nil) then
       begin
         for I := 0 to sCC.Count - 1 do
         begin
           if not smtp.MailTo(sCC.Strings[i]) then
             raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
         end;
       end;

       if not smtp.MailData(slmsg_Lines) then
         raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

       if not smtp.Logout() then
         raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     finally
       try
         smtp.Sock.CloseSocket;
       except
       end ;
       Terminado := True;
     end;
   except
     Terminado := True;
     HandleException;
   end;
end;

procedure TSendMailThread.DoHandleException;
var
  sMessage : String;
begin
   if FException is Exception then
      sMessage := FException.Message
   else
      SysUtils.ShowException(FException, nil);
end;

procedure TSendMailThread.HandleException;
begin
   FException := Exception(ExceptObject);
   try
     // Não mostra mensagens de EAbort
     if not (FException is EAbort) then
        Synchronize(DoHandleException);
   finally
     FException := nil;
   end;
end;

function TSendMailThread.EnviarEmail(const sFrom, sTo, sAssunto: String;
                                     sMensagem : TStrings;
                                     SSL       : Boolean;
                                     sCC       : TStrings = nil;
                                     Anexos    : TStrings = nil;

                                     PedeConfirma  : Boolean = False;
                                     AguardarEnvio : Boolean = False;
                                     NomeRemetente : String  = '';
                                     TLS           : Boolean = True) : boolean;
var
  ThreadSMTP : TSendMailThread;
  m          : TMimemess;
  p          : TMimepart;
  // StreamNFe  : TStringStream;
  I          : Integer;

  sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd : string;
begin
  Result := False;

  sSmtpHost   := 'mail.qualicodex.com';
  sSmtpPort   := '465';
  sSmtpUser   := 'help@qualicodex.com';
  sSmtpPasswd := 'helpQualicodex2023#';

  m := TMimemess.create;

  ThreadSMTP := TSendMailThread.Create(Application);  // Não Libera, pois usa FreeOnTerminate := True ;
  // StreamNFe  := TStringStream.Create('');

  try
    //p := m.AddPartMultipart('mixed', nil);
    p := m.AddPartMultipart('HTML text', nil);

    m.header.CharsetCode := ISO_8859_2; //  UTF_8;
    m.header.tolist.add(sTo);

    if Trim(NomeRemetente) <> '' then
      m.header.From := UTF8Encode(Format('%s<%s>', [NomeRemetente, sFrom]))
      else
        m.header.From := sFrom;

    if sMensagem <> nil then
      m.AddPartHTML(sMensagem, p);
      //m.AddPartText(sMensagem, p);

    if assigned(Anexos) then
    begin
      for I := 0 to Anexos.Count - 1 do
        m.AddPartBinaryFromFile(Anexos[I], p);
    end;

    m.header.subject := sAssunto;
    m.Header.ReplyTo := sFrom;

    if PedeConfirma then
      m.Header.CustomHeaders.Add('Disposition-Notification-To: ' + sFrom);

    m.EncodeMessage;

    ThreadSMTP.sFrom := sFrom;
    ThreadSMTP.sTo   := sTo;

    if (sCC <> nil) then
      ThreadSMTP.sCC.AddStrings(sCC);

    ThreadSMTP.slmsg_Lines.AddStrings(m.Lines);

    ThreadSMTP.smtp.UserName := sSmtpUser;
    ThreadSMTP.smtp.Password := sSmtpPasswd;

    ThreadSMTP.smtp.TargetHost := sSmtpHost;

    if (Trim(sSmtpPort) <> '') then     // Usa default
      ThreadSMTP.smtp.TargetPort := sSmtpPort;

    ThreadSMTP.smtp.FullSSL := SSL;
    ThreadSMTP.smtp.AutoTLS := TLS;

    try
      ThreadSMTP.Resume; // inicia a thread

      if AguardarEnvio then
      begin
        repeat
          Sleep(1000);
          // Application.ProcessMessages;
        until ThreadSMTP.Terminado;
      end;

      Result := True;
    except
      Result := False;
    end;

  finally
    m.free;
    // StreamNFe.Free;
  end;
end;

end.
