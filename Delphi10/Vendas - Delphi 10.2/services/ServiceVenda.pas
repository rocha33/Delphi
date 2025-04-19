unit ServiceVenda;

interface

uses
  modelVenda, System.SysUtils, System.DateUtils;

type
  TVendaService = class
  public
    function InserirVenda(pVenda: array of TVenda): Boolean;
  end;

implementation
  uses DataAccess;

function TVendaService.InserirVenda(pVenda: array of TVenda): boolean;
var
  I: Integer;
  vDatabase: TDatabase;
begin
  for I := 1 to Length(pVenda) - 1 do
  begin
    vDatabase:= TDatabase.Create(nil);
    try
      Result := vDatabase.InserirDadosBD('INSERT INTO Vendas (vd_cpfCliente, vd_modeloCarro, vd_dataVenda) ' +
        'VALUES (:CPFCliente, :ModeloCarro, now())',
        [pVenda[I].IDVenda, pVenda[I].CPFCliente, pVenda[I].ModeloCarro]);
    finally
      vDatabase.Free;
    end;
  end;
end;

end.
