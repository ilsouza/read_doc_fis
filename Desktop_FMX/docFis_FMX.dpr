program docFis_FMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMainFMX in 'src\FMainFMX.pas' {frmMain},
  UDM in 'src\UDM.pas' {dm: TDataModule},
  loginService in 'src\loginService.pas',
  loginServiceImplementation in 'src\loginServiceImplementation.pas',
  UEntities in 'src\UEntities.pas',
  searchDFService in 'src\searchDFService.pas',
  searchDFServiceImplementation in 'src\searchDFServiceImplementation.pas',
  UCrypt in '..\__share\UCrypt.pas',
  USendMail in '..\__share\USendMail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
