unit searchDFServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  XData.Client,
  XData.Sys.Exceptions,
  searchDFService,
  System.Classes,
  System.SysUtils,
  uEntities;

type
  [ServiceImplementation]
  TsearchDFService = class(TInterfacedObject, IsearchDFService)
  private
    function consultaDFe(aEmpresa : integer; aNSU : string = '') : string;
  end;

implementation

uses UDMSearchDF, ConnectionModule;

function TsearchDFService.consultaDFe(aEmpresa : integer; aNSU : string = '') : string;
var
  xdm        : TdmSearchDFe;
  xConModule : TConnectionModulePG;

  xReturn  : TStringList;
  ClientDoc : TXDataClient;
  EMPRESA   : TEmpresa;
  //Ok : Boolean;
begin
  xReturn    := TStringList.Create;
  xdm        := TdmSearchDFe.Create(nil);
  xConModule := TConnectionModulePG.Create(nil);

  ClientDoc     := TXDataClient.Create;
  ClientDoc.Uri := URL_SERVER;

  EMPRESA := xConModule.auManager.Find<Tempresa>(aEmpresa);

  try
    try
      xdm.ConsultaNF(xReturn, EMPRESA, aNSU);
    finally
      Result := xReturn.GetText;
      xReturn.DisposeOf;
      xdm.DisposeOf;
      ClientDoc.DisposeOf;
      EMPRESA.DisposeOf;
    end;
  except
    on e : exception do
    begin
      Result := 'erro: ' + xReturn.GetText;

      xReturn.DisposeOf;
      xConModule.DisposeOf;
      xdm.DisposeOf;
      ClientDoc.DisposeOf;
      EMPRESA.DisposeOf;
    end;
  end;
end;

initialization
  RegisterServiceType(TsearchDFService);

end.
