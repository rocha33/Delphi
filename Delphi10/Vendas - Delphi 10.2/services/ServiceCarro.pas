unit ServiceCarro;

interface

uses
  modelCarros, System.SysUtils;

type
  TCarroService = class
  public
    function InserirCarros(pCarros: array of TCarro): Boolean;
  end;

implementation
  uses DataAccess;

function TCarroService.InserirCarros(pCarros: array of TCarro): Boolean;
var
  I: Integer;
  vDatabase: TDatabase;
begin
  for I := 1 to Length(pCarros) - 1 do
  begin
    vDatabase:= TDatabase.create(nil);
    try
      result:= vDatabase.InserirDadosBD('INSERT INTO carros (cr_modelo, cr_anoLancamento) VALUES (:Modelo, :AnoLancamento)',
                                         [pCarros[I].Modelo, pCarros[I].AnoLancamento]);
    finally
      vDatabase.Free;
    end;
  end;
end;

end.
