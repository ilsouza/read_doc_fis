unit UCrypt;

interface

uses
  System.AnsiStrings, System.SysUtils;

  function Crypt(Action, Src: String): String;

implementation

function Crypt(Action, Src: String): String;
var
  KeyLen, KeyPos, OffSet,
  SrcPos, SrcAsc, TmpSrcAsc, Range : Integer;

  Dest, Key : String;
begin
  if (SameStr(Src, '')) Then
  begin
    Result:= '';
    Exit;
  end;

  // Chave de criptografia e descriptografia
  Key := '97507490653';

  Dest   := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range  := 256;

  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest   := Format('%1.2x', [OffSet]);

    for SrcPos := 1 to Length(Src) do
    begin
      // Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;

      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;

      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest   := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
    else if (Action = UpperCase('D')) then
    begin
      OffSet := StrToInt('$'+ copy(Src, 1, 2));
      SrcPos := 3;

      repeat
        SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));

        if (KeyPos < KeyLen) Then
           KeyPos := KeyPos + 1
        else
           KeyPos := 1;

        TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);

        if TmpSrcAsc <= OffSet then
          TmpSrcAsc := 255 + TmpSrcAsc - OffSet
        else
          TmpSrcAsc := TmpSrcAsc - OffSet;

        Dest   := Dest + Chr(TmpSrcAsc);
        OffSet := SrcAsc;
        SrcPos := SrcPos + 2;
      until
        (SrcPos >= Length(Src));

    end;

  Result:= Dest;
end;


end.
