program qualiBase;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  FLogin in 'src\FLogin.pas' {frmLgin: TWebForm} {*.html},
  FSignUp in 'src\FSignUp.pas' {frmSignUp: TWebForm} {*.html},
  SweetAlerts in '..\__share\SweetAlerts.pas',
  UwebDM in 'src\UwebDM.pas' {webDM: TWebDataModule},
  FDashBoard in 'src\FDashBoard.pas' {frmDashBoard: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmDashBoard, frmDashBoard);
  Application.Run;
end.
