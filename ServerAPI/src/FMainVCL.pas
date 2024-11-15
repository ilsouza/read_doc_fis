unit FMainVCL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    panTop: TPanel;
    panBottom: TPanel;
    panLog: TPanel;
    memLog: TMemo;
    lblStatus: TLabel;
    btnConnect: TButton;
    procedure btnConnectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  UDM;

{$R *.dfm}

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  memLog.Lines.Add(dm.UpdateGUI);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  memLog.Lines.Add(dm.UpdateGUI);
end;

end.
