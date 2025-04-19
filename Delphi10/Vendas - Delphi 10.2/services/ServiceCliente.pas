unit ServiceCliente;

interface

uses
  modelCliente, System.SysUtils;

type
  TClienteService = class
  public
    function InserirCliente(pClientes: array of TCliente): Boolean;
  end;

implementation
   uses DataAccess;

function TClienteService.InserirCliente(pClientes: array of TCliente): Boolean;
var
  I: Integer;
  vDatabase: TDatabase;
begin
  vDatabase := TDatabase.Create(nil);
  try
    for I := 0 to Length(pClientes) - 1 do
    begin
      if(not pClientes[I].CPF.IsEmpty) and (not pClientes[I].Nome.IsEmpty)then
      begin
        Result := vDatabase.InserirDadosBD('INSERT INTO clientes (cli_CPF, cli_Nome) VALUES (:CPF, :Nome)',
                                         [pClientes[I].CPF, pClientes[I].Nome]);
      end;

    end;

  finally
    vDatabase.Free;
  end;

end;

end.
