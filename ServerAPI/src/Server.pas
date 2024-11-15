unit Server;

interface

uses
  System.SysUtils, System.JSON,

  Bcl.Jose.Core.JWT, Bcl.Jose.Core.Builder,

  {$ifdef MSWINDOWS}
    Sparkle.HttpSys.Server,
  {$else}
    Sparkle.Indy.Server,
  {$endif}

  Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context,

  // ---------------------- Módulos extras
  Sparkle.Middleware.Logging,
  Sparkle.Middleware.Cors,
  Sparkle.Middleware.Compress,
  Sparkle.Middleware.Jwt,

  XData.Server.Module,
  XData.SwaggerUI.Service,
  XData.Module.Events,
  XData.OpenApi.Service,
  XData.Aurelius.ConnectionPool,
  XData.Sys.Exceptions,
  XData.Aurelius.ModelBuilder,

  Aurelius.Engine.DatabaseManager,
  Aurelius.Drivers.FireDac,
  Aurelius.Drivers.Base,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.ObjectManager,

  ConnectionModule;

  procedure UpdateDatabase(_Connection: IDBConnection);
  procedure StartServer;

implementation

uses
  System.IOUtils;

procedure StartServer;
var
  LoginModule : TLoggingMiddleware;
  Compress    : ICompressMiddleware;
  JWT_Mid     : TJwtMiddleware;
  Context     : TXDataOperationContext;
  Cors        : TCorsMiddleware;

  Server             : {$ifdef MSWINDOWS}THttpSysServer{$else}TIndySparkleHTTPServer{$endif};
  XDataServerModule  : TXDataServerModule;
  ConnectionPool     : TDBConnectionPool;
  ConnectionFactory  : TDBConnectionFactory;
  ConnectionModulePG : TConnectionModulePG;

begin
  Server := {$ifdef MSWINDOWS}THttpSysServer{$else}TIndySparkleHTTPServer{$endif}.Create;

  try
    ConnectionFactory := TDBConnectionFactory.create(
      function: IDBConnection
      begin
        // Using FireDac and Data Module
        ConnectionModulePG := TConnectionModulePG.create(nil);
        Result := TFireDacConnectionAdapter.create(ConnectionModulePG.fdDocFis_Conn, ConnectionModulePG);
        UpdateDatabase(Result);
      end
    );

    ConnectionPool    := TDBConnectionPool.create(15, ConnectionFactory);
    XDataServerModule := TXDataServerModule.create(URL_SERVER, ConnectionPool);

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
      XDataServerModule.XModel.Description := 'versão Console FMX';

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

          LPair.AddPair('erro ' + Args.ErrorCode, Args.ErrorMessage);
          LObject.AddPair('value', LPair);

          Context := TXDataOperationContext.Current;

          Context.Response.StatusCode   := Args.StatusCode;
          Context.Response.StatusReason := LObject.ToString;
        end
      );

    Server.{$ifndef MSWINDOWS}Dispatcher.{$endif}AddModule(XDataServerModule);

    Server.{$ifdef MSWINDOWS}Start{$else}StartListening{$endif};

    WriteLn('Server started. Press ENTER to stop.');
    ReadLn;
  finally
    Server.DisposeOf;
  end;
end;

procedure UpdateDatabase(_Connection: IDBConnection);
var
  LDb      : TDatabaseManager;
  LManager : TObjectManager;
begin
  LDb := TDatabaseManager.create(_Connection);

  try
    LDb.UpdateDatabase;
  finally
    LDb.DisposeOf;
  end;

  LManager := TObjectManager.create(_Connection);

  try
    // TXdataDataGenerator.generateSampleData(LManager,100);
  finally
    LManager.DisposeOf;
  end;
end;

procedure StopServer;
begin
  //
end;

end.
