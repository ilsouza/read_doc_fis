library mod_docfis;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  WebModule_docfis in 'src\WebModule_docfis.pas' {WebMod_docfis: TWebModule},
  ConnectionModule in 'src\ConnectionModule.pas' {ConnectionModulePG: TDataModule},
  UEntities in 'src\UEntities.pas',
  searchDFService in 'src\searchDFService.pas',
  searchDFServiceImplementation in 'src\searchDFServiceImplementation.pas',
  UDMSearchDF in 'src\UDMSearchDF.pas' {dmSearchDFe: TDataModule},
  loginService in 'src\loginService.pas',
  loginServiceImplementation in 'src\loginServiceImplementation.pas',
  USendMail in '..\__share\USendMail.pas',
  UCrypt in '..\__share\UCrypt.pas';

{$R *.res}

(*
  /etc/apache2/mods-available

    docfis.conf --------------------------------
      <Location /docfis/v1/xData>
          SetHandler libmod_docfis-handler
      </Location>

    docfis.load --------------------------------
      LoadModule docfis_module /home/ubuntu/docfis/ivan-qualiserver-ORACLE/mod_docfis/libmod_docfis.so
*)

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'docfis_module';

begin
  {$IFDEF MSWINDOWS}
    CoInitFlags := COINIT_MULTITHREADED;
  {$ENDIF}

  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  // Application.CreateForm(TConnectionModulePG, ConnectionModulePG);
  // Application.CreateForm(TdmSearchDFe, dmSearchDFe);
  Application.Run;
end.
