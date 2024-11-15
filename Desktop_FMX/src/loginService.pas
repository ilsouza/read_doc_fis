unit loginService;

interface

uses
  XData.Service.Common, System.Classes, JSON;

type
  [ServiceContract]
  IloginService = interface(IInvokable)
    ['{81B975DF-2DF0-4A31-828B-2195D0B8E590}']
    function GetLogin(sUser, sPassword : string) : TJsonObject;
    function GetToken(sIDToken : string) : TJsonObject;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IloginService));

end.
