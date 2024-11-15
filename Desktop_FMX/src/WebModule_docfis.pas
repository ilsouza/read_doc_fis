unit WebModule_docfis;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Web.HTTPApp;

type
  TWebMod_docfis = class(TWebModule)
    procedure WebModule2DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebMod_docfis;

implementation

uses
  Bcl.Jose.Core.JWT, Bcl.Jose.Core.Builder,

  Sparkle.WebBroker.Server,
  Sparkle.WebBroker.Adapter,
  Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context,

  // ---------------------- Módulos extras
  Sparkle.Middleware.Logging,
  Sparkle.Middleware.Cors,
  Sparkle.Middleware.Compress,
  Sparkle.Middleware.Jwt,

  XData.Server.Module,
  XData.SwaggerUI.Service,
  XData.Aurelius.ModelBuilder,
  XData.Module.Events,
  XData.Aurelius.Model,
  XData.Security.Attributes,
  XData.Sys.Exceptions,

  Aurelius.Engine.DatabaseManager,
  Aurelius.Mapping.Explorer,
  Aurelius.Linq,

  ConnectionModule ;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebMod_docfis.WebModule2DefaultHandlerAction(Sender: TObject;
                         Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  LoginModule : TLoggingMiddleware;
  Compress    : ICompressMiddleware;
  JWT_Mid     : TJwtMiddleware;
  Adapter     : TWebBrokerAdapter;
  Server      : TWebBrokerServer;
  Cors        : TCorsMiddleware;

  XDataServerModule : TXDataServerModule;
begin
  // Cria servidor
  Server := TWebBrokerServer.Create;

  try
    // Cria conexão com o Postgres
    ConnectionModulePG := TConnectionModulePG.Create(nil);
    ConnectionModulePG.conDocFis_API.Connected := True;

    XDataServerModule  := TXDataServerModule.Create(URL_SERVER, TConnectionModulePG.CreateConnection);

    // Cria conexão com o Aurelius
    TDatabaseManager.Update(TConnectionModulePG.CreateConnection);

      // Cross origin
      Cors := TCorsMiddleware.Create;
      XDataServerModule.AddMiddleware(Cors);
      XDataServerModule.AccessControlAllowOrigin := '*';

      // Cria modelo para o Swagger
      XDataServerModule.SwaggerOptions.AuthMode             := TSwaggerAuthMode.Jwt;
      XDataServerModule.SwaggerUIOptions.DisplayOperationId := True;
      XDataServerModule.SwaggerUIOptions.ShowFilter         := True;

      XDataServerModule.XModel.Title       := 'docServer API';
      XDataServerModule.XModel.Version     := '1.0';
      XDataServerModule.XModel.Description := 'versão Console APACHE';

      TXDataModelBuilder.LoadXmlDoc(XDataServerModule.XModel);

      // Compress middleware
      Compress           := TCompressMiddleware.Create;
      Compress.Threshold := 2048;
      XDataServerModule.AddMiddleware(Compress);

      // Logging middleware
      LoginModule := TLoggingMiddleware.Create;
      XDataServerModule.AddMiddleware(LoginModule);

      // JWT Middleware
      JWT_Mid := TJwtMiddleware.Create(JWT_SECRET);
      XDataServerModule.AddMiddleware(JWT_Mid);

      // Adicionando evento de autenticação do JWT
      XDataServerModule.Events.OnEntityDeleting.Subscribe(
        procedure(Args: TEntityDeletingArgs)
        var
          User: IUSerIdentity;
          IsAdmin : Boolean;
        begin
          User    := TXDataOperationContext.Current.Request.User;
          IsAdmin := (User <> nil) and User.Claims.Exists('isadmin');

          if not IsAdmin then
            raise EXDataHttpForbidden.Create('Not enough privileges');

          (*
            if (User = nil) then
              raise EXDataHttpUnauthorized.Create('User not authenticated');

            if not (User.Claims.Exists('isadmin')) then
              raise EXDataHttpForbidden.Create('Not enough privileges');
          *)
        end
      );

      // Adicionando evento para o verbo Get
      XDataServerModule.Events.OnEntityGet.Subscribe(
        procedure(Args: TEntityGetArgs)
        var
          User: IUSerIdentity;
          IsAdmin : Boolean;
        begin
          User    := Args.Handler.Request.User;
          IsAdmin := (User <> nil) and User.Claims.Exists('isadmin');

          if not IsAdmin then
            raise EXDataHttpForbidden.Create('Not enough privileges');
        end
      );

      // Adicionando evento para o verbo List
      XDataServerModule.Events.OnEntityList.Subscribe(
        procedure(Args: TEntityListArgs)
        var
          User    : IUSerIdentity;
          IsAdmin : Boolean;
        begin
          User := Args.Handler.Request.User;
          IsAdmin := ((User <> nil) and User.Claims.Exists('isadmin'));

          if not IsAdmin then
            // Args.Criteria.Add(not Linq['Protected']);
            raise EXDataHttpForbidden.Create('Not enough privileges');
        end
      );

      // Adicionando evento para Request Exception
      XDataServerModule.Events.OnModuleException.Subscribe(
        procedure (Args: TModuleExceptionArgs)
        var
          LObject, LPair : TJSONObject;
        begin
          LObject := TJSONObject.Create(nil);
          LPair   := TJSONObject.Create(nil);

//          if Args.Exception is EXDataHTTPException then
//          begin
//          Args.StatusCode := 406;
//          Args.Action := TModuleExceptionAction.RaiseException;
//          end;

          LPair.AddPair('erro ' + Args.ErrorCode, Args.ErrorMessage);
          LObject.AddPair('value', LPair);

          Response.StatusCode := Args.StatusCode;
          Response.Content := LObject.ToString;
        end
      );

      // Mudando a chamada de http para https
      XDataServerModule.OnGetAbsoluteUrl :=
        procedure (const Schema, Authority, Path, RelativeUrl: string; var Url: string)
        begin
          Url := StringReplace(Url, 'http://', 'https://', []);
        end;

    // Adiciona módulo XData ao servidor
    Server.Dispatcher.AddModule(XDataServerModule);

    Adapter := TWebBrokerAdapter.Create(Request, Response);
    Server.DispatchRequest(Adapter);

    Server.Free;
    ConnectionModulePG.Free;
  except
    on e: exception do
    begin
      if (Server <> nil) then Server.DisposeOf;
      if (ConnectionModulePG <> nil) then ConnectionModulePG.DisposeOf;

      Response.Content := Format('%s: %s', [e.ClassName, e.Message]);
    end;
  end;
end;

end.
