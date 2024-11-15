unit SweetAlerts;

interface
  function swalPrompt(pTitle, pText, pConfirmed, pCanceled : String): String;

  function swalAlert(pTitle, pText: String): String;
  function swalError(pTitle, pText: String): String;
  function swalSuccess(pTitle, pText: String): String;

implementation

function swalPrompt(pTitle, pText, pConfirmed, pCanceled : String): String;
var
  LJSCommand : String;
begin
  LJSCommand := '{' + #13 +
                '  title: "' + pTitle + '",' + #13 +
                '  text: "' + pText + '",' + #13 +
                '  icon: "' + 'warning' + '",' + #13 +
                '  showCancelButton: true, ' + #13 +
                '  confirmButtonColor: "' + '#3085d6' + '",' + #13 +
                '  cancelButtonColor: "' + '#d33' + '",' + #13 +
                '  confirmButtonText: "' + 'Yes, delete it!"' + #13 +
                '}).then((result) => {' + #13 +
                '  if (result.isConfirmed) {' + #13 +
                '    $mod.' + pConfirmed + '();' + #13 +
                '  } else {$mod.' + pCanceled + '()}' + #13 +
                '}';

  Result := LJSCommand;
end;

function swalAlert(pTitle, pText: String): String;
var
  LJSCommand : String;
begin
  LJSCommand := '"' + pTitle + '", "' + pText + '", "warning"';
  Result := LJSCommand;
end;

function swalError(pTitle, pText: String): String;
var
  LJSCommand : String;
begin
  LJSCommand := '"' + pTitle + '", "' + pText + '", "error"';
  Result := LJSCommand;
end;

function swalSuccess(pTitle, pText: String): String;
var
  LJSCommand : String;
begin
  LJSCommand := '"' + pTitle + '", "' + pText + '", "success"';
  Result := LJSCommand;
end;

end.
