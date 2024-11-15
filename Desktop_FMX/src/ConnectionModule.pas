unit ConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces, Aurelius.Drivers.FireDac, FireDAC.Dapt,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Aurelius.Sql.PostgreSQL, Aurelius.Schema.PostgreSQL, Aurelius.Comp.Connection,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  Aurelius.Engine.ObjectManager, Aurelius.Linq, Aurelius.Comp.Manager,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TConnectionModulePG = class(TDataModule)
    fdDocFis_Conn: TFDConnection;
    auDocFis_Conn: TAureliusConnection;
    auManager: TAureliusManager;
    FDQuery1: TFDQuery;
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
  end;

var
  ConnectionModulePG: TConnectionModulePG;

const
  {$ifdef DOCFIS_LOCAL}
    URL_SERVER = 'http://localhost:2001/kiosko/v1/xdata'; //  'http://+:2001/kiosko/v1/xdata';
  {$else}
    URL_SERVER = 'https://e-store.com.br/kiosko/v1/xData';
  {$endif}

  JWT_SECRET = 'keyKioskoChile##2023_keyKioskoChile##2023_';
implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TConnectionModulePG.CreateConnection: IDBConnection;
begin
  try
    Result := ConnectionModulePG.auDocFis_Conn.CreateConnection;
  except
    on e : exception do
      raise Exception.Create(e.message);
  end;
end;

class function TConnectionModulePG.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;

end.
