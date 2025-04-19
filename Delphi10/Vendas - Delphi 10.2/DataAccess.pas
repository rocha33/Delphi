unit DataAccess;

interface

uses
  System.SysUtils, FireDAC.Comp.Client;

type
  TDatabase = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function InserirDadosBD(const ASql: string; const AParams: array of Variant): Boolean;
  end;

implementation

constructor TDatabase.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;


// como orientado no teste
//Obs: Utilizar método fictício InserirDadosBD (para inserção de dados)
//Obs: Utilizar método fictício ExecutarSql (para carregar informações do banco de dados)
function TDatabase.InserirDadosBD(const ASql: string; const AParams: array of Variant):Boolean;
var
  vQuery: TFDQuery;
  I: Integer;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := FConnection;
    vQuery.SQL.Text := ASql;
    for I := 0 to High(AParams) do
      vQuery.Params[I].Value := AParams[I];
    //Result := vQuery.ExecSQL;
  finally
    vQuery.Free;
  end;
end;

end.
