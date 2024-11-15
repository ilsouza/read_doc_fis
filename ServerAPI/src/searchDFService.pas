unit searchDFService;

interface

uses
  XData.Service.Common, UEntities;

type
  [ServiceContract]
  IsearchDFService = interface(IInvokable)
    ['{21DBCB2B-6824-42A0-9C15-1CF9FB5DA3BC}']
    [HttpGet]function consultaDFe(aEmpresa : integer; aNSU : string = '') : string;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IsearchDFService));

end.
