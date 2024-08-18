unit Rotina;

interface
type
  TAcao = (tacIndefinido, tacIncluir, tacAlterar, tacExcluir);

function IsDigit(pTexto : string): Boolean;
function SoNumero(pTexto: string): string;
function RemoveCaracter(pTexto: string; Caracter: Char): string;

implementation

uses
  System.SysUtils;

function SoNumero(pTexto: string): string;
var
  I: integer;
  S: string;
begin
  S := '';
  for I := 1 to Length(pTexto) do
  begin
     if (pTexto[I] in ['0'..'9']) then
     begin
        S := S + Copy(pTexto, I, 1);
     end;
  end;

  s := RemoveCaracter(s,' ');

  result := S;
end;

function RemoveCaracter(pTexto: string; Caracter: Char): string;
var
   Comprimento: Integer;
   Contador: Integer;
   Resposta: string;
begin
   Comprimento := length(pTexto);
   Resposta := '';

   for Contador := 1 to Comprimento do
   begin
      if pTexto[Contador] <> Caracter then
         Resposta := Resposta + pTexto[Contador];
   end;

   Result := Resposta;
end;

function IsDigit(pTexto : string): Boolean;
begin
  result := true;
  try
    StrToInt(pTexto);
  except
    Result := false;
  end;
end;


end.
