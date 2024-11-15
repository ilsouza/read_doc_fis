unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, JSON, System.NetEncoding, Bcl.Json.Classes,

  Sparkle.HttpServer.Module, Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Sparkle.Comp.CorsMiddleware,
  Sparkle.Comp.JwtMiddleware, Sparkle.Security,

  XData.Server.Module, XData.Comp.Server, XData.Comp.ConnectionPool, XData.Sys.Exceptions,
  XData.Module.Events,

  Aurelius.Sql.PostgreSQL, Aurelius.Schema.PostgreSQL, Aurelius.Drivers.FireDac,
  Aurelius.Comp.Connection, Aurelius.Drivers.Interfaces,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.StorageJSON,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove.JSON,
  FireDAC.Comp.UI;

type
  Tdm = class(TDataModule)
    XDataServer1: TXDataServer;
    SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher;
    XDataServer1CORS: TSparkleCorsMiddleware;
    AureliusConnection1: TAureliusConnection;
    connection: TFDConnection;
    XDataConnectionPool1: TXDataConnectionPool;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    XDataServer1JWT: TSparkleJwtMiddleware;
    procedure SparkleHttpSysDispatcher1Start(Sender: TObject);
    procedure SparkleHttpSysDispatcher1Stop(Sender: TObject);
    procedure XDataServer1EntityGet(Sender: TObject; Args: TEntityGetArgs);
    procedure XDataServer1EntityList(Sender: TObject; Args: TEntityListArgs);
    procedure XDataServer1EntityModified(Sender: TObject; Args:
        TEntityModifiedArgs);
    procedure XDataServer1JWTForbidRequest(Sender: TObject; Context:
        THttpServerContext; var Forbid: Boolean);
    procedure XDataServer1JWTGetSecretEx(Sender: TObject; const JWT: TJWT; Context:
        THttpServerContext; var Secret: TArray<System.Byte>);
  private
    { Private declarations }
  public
    { Public declarations }
    function UpdateGUI : string;
    function GetDataSetToJSONObject(DataSet: TFDQuery): TJsonObject;
  end;

const
  {$ifdef DOCFIS_CONSOLE}
    URL_SERVER = 'https://qualicodex.com.br/docfis/v1/xData';
  {$else}
    URL_SERVER = 'http://localhost:2001/docfis/v1/xdata'; //
  {$endif}

  JWT_SECRET = 'keyReadDocFis##2023_keyReadDocFis##2023_';
var
  dm: Tdm;
  JWT_OK : Boolean;

implementation

uses
  UEntities,
  FMainFMX
  {$ifdef MSWINDOWS}, System.Variants{$endif};

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

resourcestring
  SServerStopped   = 'Server STOPPED';
  SServerStartedAt = 'Server STARTED at ';

procedure Tdm.SparkleHttpSysDispatcher1Start(Sender: TObject);
begin
  frmMain.lblStatus.Text := 'Server STARTED';
end;

procedure Tdm.SparkleHttpSysDispatcher1Stop(Sender: TObject);
begin
  try
    frmMain.lblStatus.Text := 'Server NOT STARTED';
  except
  end;
end;

function Tdm.UpdateGUI : string;
begin
  if dm.SparkleHttpSysDispatcher1.Active then
  begin
    dm.SparkleHttpSysDispatcher1.Active := False;

    result  := SServerStopped;
    frmMain.btnConnect.Text := 'START';
  end
    else
    begin
      dm.XDataServer1.BaseUrl := URL_SERVER;
      dm.SparkleHttpSysDispatcher1.Active := True;

      dm.XDataServer1.Model.Title       := 'docServer API';
      dm.XDataServer1.Model.Version     := '1.0';
      dm.XDataServer1.Model.Description := 'vesão Desktop FMX';

      frmMain.btnConnect.Text := 'STOP';
      result  := (SServerStartedAt + URL_SERVER);
    end;

  connection.Connected := SparkleHttpSysDispatcher1.Active;
end;

function Tdm.GetDataSetToJSONObject(DataSet : TFDQuery): TJsonObject;
var
  LObject, LFinalObject : TJSONObject;
  LArray: TJSONArray;

  i: Integer;
begin
  LArray  := TJSONArray.Create;
  LObject := TJSOnObject.Create;

  DataSet.First;

  while not DataSet.eof do begin
    for i := 0 to DataSet.Fields.Count-1 do
    begin
      LObject.AddPair(DataSet.Fields[i].FieldName, VarToStr(DataSet.Fields[i].Value));
    end;

    LArray.AddElement(LObject);
    DataSet.Next;
  end;

  LFinalObject := TJSOnObject.Create;
  LFinalObject.AddPair(DataSet.Name, LArray);

  Result := LFinalObject;
end;

procedure Tdm.XDataServer1EntityGet(Sender: TObject; Args: TEntityGetArgs);
var
  User       : IUserIdentity;
  LTableName : String;
begin
  User       := Args.Handler.Request.User;
  LTableName := Args.Entity.ToString;

  if User = nil then
    raise EXDataHttpUnauthorized.Create('User not authenticated');

  if not User.Claims.Exists('admin') then
    raise EXDataHttpForbidden.Create('Not enough privileges');
end;

procedure Tdm.XDataServer1EntityList(Sender: TObject; Args: TEntityListArgs);
var
  User : IUserIdentity;
begin
  User := TXDataOperationContext.Current.Request.User;

  if User = nil then
    raise EXDataHttpUnauthorized.Create('User not authenticated');

  if not User.Claims.Exists('admin') then
    raise EXDataHttpForbidden.Create('Not enough privileges');
end;

procedure Tdm.XDataServer1EntityModified(Sender: TObject; Args:
    TEntityModifiedArgs);
var
  User : IUserIdentity;
begin
  User := Args.Handler.Request.User;

  if User = nil then
    raise EXDataHttpUnauthorized.Create('User not authenticated');

  if not User.Claims.Exists('admin') then
    raise EXDataHttpForbidden.Create('Not enough privileges');
end;

procedure Tdm.XDataServer1JWTForbidRequest(Sender: TObject; Context:
              THttpServerContext; var Forbid: Boolean);
//var
  //bForb : Boolean;
begin
  //bForb := Forbid;
end;

procedure Tdm.XDataServer1JWTGetSecretEx(Sender: TObject; const JWT: TJWT;
              Context: THttpServerContext; var Secret: TArray<System.Byte>);
begin
  Secret := TEncoding.UTF8.GetBytes(JWT_SECRET);
end;


Initialization
  JWT_OK := False;

end.
