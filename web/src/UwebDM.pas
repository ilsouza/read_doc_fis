unit UwebDM;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, XData.Web.Connection;

type
  TwebDM = class(TWebDataModule)
    XDataWebConn_docfis: TXDataWebConnection;
    procedure WebDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  gSUCCESS  = 'success';
  gERROR    = 'error';
  gWARNING  = 'warning';
  gINFO     = 'info';
  gQUESTION = 'question';

const
  URL_SERVER = 'https://qualicodex.com.br/docfis/v1/xData';

var
  webDM: TwebDM;

  MESSAGE_RESULT : Boolean;
  TOKEN          : string;

  procedure MessageJS(aTitle, aText, aType : String);
  procedure MessageDialogJS(aTitle, aText, aIcon, aConfirmButtonText, aCancelButtonText : String);

  function Message_Confirmed : Boolean;
  function Message_Canceled : Boolean;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure MessageJS(aTitle, aText, aType : String);
var
  LTitle, LText, LType : String;
begin
  asm
    Swal.fire(
      aTitle,
      aText,
      aType
    );
  end;
end;

procedure MessageDialogJS(aTitle, aText, aIcon, aConfirmButtonText, aCancelButtonText : String);
var
  sString, strAux : String;
  sOk : String;
begin
  {
    ICONS:

    success
    error
    warning
    info
    question
  }

  {$ifdef pas2js}
    asm
      var ok = 0
      Swal.fire({
        title: aTitle,
        text: aText,
        icon: aIcon,
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: aConfirmButtonText,
        cancelButtonText: aCancelButtonText
      }).then((result) => {
        if (result.isConfirmed) {
          $mod.Message_Confirmed();
        } else {$mod.Message_Canceled()}
      });

      sOk = ok;
    end;
  {$endif}
end;

function Message_Confirmed : Boolean;
begin
  MessageJS('Título janela', 'Texto janela', gSUCCESS);

  MESSAGE_RESULT := True;
  result := True;
end;

function Message_Canceled : Boolean;
begin
  MessageJS('Título janela', 'Texto janela', gERROR);

  MESSAGE_RESULT := False;
  result := False;
end;

procedure TwebDM.WebDataModuleCreate(Sender: TObject);
begin
  XDataWebConn_docfis.URL := URL_SERVER;
end;

end.
