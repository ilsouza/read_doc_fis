unit invoicesImagesService;

interface

uses
  XData.Service.Common, System.Classes, JSON;

type
  [ServiceContract]
  IinvoicesImagesService = interface(IInvokable)
    ['{8684C79B-8B73-4349-886B-E31428D7F6CB}']
    [HttpGet] function Sum(A, B: double): double;

    {By default, any service operation responds to (is invoked by) a POST request from the client}
    function EchoString(Value: string): string;
    [HttpGet] function GetImage(sID : String) : TJSONObject;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IinvoicesImagesService));

end.
