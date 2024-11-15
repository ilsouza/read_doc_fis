unit FMainFMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TfrmMain = class(TForm)
    panTop: TPanel;
    panBottom: TPanel;
    panLog: TPanel;
    lblStatus: TLabel;
    memLog: TMemo;
    btnConnect: TButton;
    procedure btnConnectClick(Sender: TObject);
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

{$R *.fmx}

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  dm.UpdateGUI;
end;

end.
