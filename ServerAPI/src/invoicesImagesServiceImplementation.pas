unit invoicesImagesServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  invoicesImagesService, System.Classes, System.SysUtils, JSON,
  FireDAC.Stan.Intf, System.Variants, FireDAC.Comp.Client, UDM;

type
  [ServiceImplementation]
  TinvoicesImagesService = class(TInterfacedObject, IinvoicesImagesService)
  private
    function Sum(A, B: double): double;
    function EchoString(Value: string): string;
    function GetImage(sID : String) : TJSONObject;
  end;

implementation

function TinvoicesImagesService.GetImage(sID : String) : TJSONObject;
var
  sSql    : string;
  LObject : TJSONObject;
begin
//  sSql := 'select encode(bilde, ' + QuotedStr('base64') + ') from rgnbilder where id = ' + QuotedStr(sID);
  sSql := 'select encode(bilde, ' + QuotedStr('base64') + ') as image64 from rgnbilder limit 10'; // where id = ' + QuotedStr(sID);

  dm.qryInvoicesImages.Close;
  dm.qryInvoicesImages.SQL.Clear;
  dm.qryInvoicesImages.SQL.Add(sSql);
  dm.qryInvoicesImages.Open;

  LObject := TJSONObject.Create;

  if not dm.qryInvoicesImages.IsEmpty then
  begin
    LObject := dm.GetDataSetToJSONObject(dm.qryInvoicesImages);
  end;

  Result := LObject;
end;

function TinvoicesImagesService.Sum(A, B: double): double;
begin
  Result := A + B;
end;

function TinvoicesImagesService.EchoString(Value: string): string;
begin
  Result := Value;
end;

initialization
  RegisterServiceType(TinvoicesImagesService);

end.
