program docFis_FMXConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Server in 'src\Server.pas',
  ConnectionModule in 'src\ConnectionModule.pas' {ConnectionModulePG: TDataModule},
  loginService in 'src\loginService.pas',
  loginServiceImplementation in 'src\loginServiceImplementation.pas',
  UEntities in 'src\UEntities.pas',
  searchDFService in 'src\searchDFService.pas',
  searchDFServiceImplementation in 'src\searchDFServiceImplementation.pas',
  UDMSearchDF in 'src\UDMSearchDF.pas' {dmSearchDFe: TDataModule},
  UCrypt in '..\__share\UCrypt.pas',
  USendMail in '..\__share\USendMail.pas';

var
  InputText : string;

begin
  try
    Write('Starting server... ');
    StartServer;
    WriteLn('done.');
    WriteLn('');

    Write('Press ENTER to stop the server and quit.');
    ReadLn(InputText);

    WriteLn('');
    Write('Stopping server... ');
    // StopServer;
    WriteLn('done.');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
