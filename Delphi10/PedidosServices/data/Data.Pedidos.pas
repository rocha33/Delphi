unit Data.Pedidos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client,
  Util.Conexao, Status.StatusPedido;

type
  TDataPedidos = class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    class var FInstance: TDataPedidos;
    constructor Create;
  public
    destructor Destroy; override;
    class function Instance: TDataPedidos;
    class procedure DestroyInstance;

    // Métodos para manipulação de dados
    function BuscarPedidosAguardando: TArray<Integer>;
    procedure AtualizarStatus(pIdPedido: Integer; pStatus: TStatusPedido; pDataProcessamento: TDateTime);
    procedure RegistrarLog(pIdPedido: Integer; const pMensagem: string);
  end;

implementation

{ TDataPedidos }

constructor TDataPedidos.Create;
begin
  FConnection := TConexao.Create.GetConn;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;
end;

destructor TDataPedidos.Destroy;
begin
  FQuery.Free;
  FConnection.Free;
  inherited Destroy;
end;

class function TDataPedidos.Instance: TDataPedidos;
begin
  // isso para criar uma unica estancia
  if not Assigned(FInstance) then
    FInstance := TDataPedidos.Create;
  Result := FInstance;
end;

class procedure TDataPedidos.DestroyInstance;
begin
  if Assigned(FInstance) then
    FreeAndNil(FInstance);
end;

function TDataPedidos.BuscarPedidosAguardando: TArray<Integer>;
var
  Ids: TArray<Integer>;
  I: Integer;
begin
  try
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT ID_PEDIDO FROM PEDIDOS WHERE STATUS = :STATUS';
    FQuery.ParamByName('STATUS').AsString := 'AGUARDANDO';
    FQuery.Open;
    SetLength(Ids, FQuery.RecordCount);
    I := 0;
    while not FQuery.Eof do
    begin
      Ids[I] := FQuery.FieldByName('ID_PEDIDO').AsInteger;
      Inc(I);
      FQuery.Next;
    end;
    Result := Ids;
  except
    on E: Exception do
    begin
      RegistrarLog(0, 'Erro ao buscar pedidos aguardando: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TDataPedidos.AtualizarStatus(pIdPedido: Integer; pStatus: TStatusPedido; pDataProcessamento: TDateTime);
var
  StatusStr: string;
begin
  try
    case pStatus of
      spAguardando: StatusStr := 'AGUARDANDO';
      spProcessando: StatusStr := 'PROCESSANDO';
      spConcluido: StatusStr := 'CONCLUIDO';
      spFalha: StatusStr := 'FALHA';
    end;
    FQuery.Close;
    FQuery.SQL.Text := 'UPDATE PEDIDOS SET STATUS = :STATUS, DT_PROCESSAMENTO = :DT_PROCESSAMENTO WHERE ID_PEDIDO = :ID_PEDIDO';
    FQuery.ParamByName('STATUS').AsString := StatusStr;
    FQuery.ParamByName('DT_PROCESSAMENTO').AsDateTime := pDataProcessamento;
    FQuery.ParamByName('ID_PEDIDO').AsInteger := pIdPedido;
    FQuery.ExecSQL;
  except
    on E: Exception do
    begin
      RegistrarLog(pIdPedido, 'Erro ao atualizar status do pedido: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TDataPedidos.RegistrarLog(pIdPedido: Integer; const pMensagem: string);
var vLogFile: TextFile;
  procedure salvaLogTxt(mensagem: string);
  begin
     // isso para garantir o log, mesmo sem pedidos
     AssignFile(vLogFile, ExtractFilePath(ParamStr(0)) + 'ServicoLog.txt');
     if FileExists(ExtractFilePath(ParamStr(0)) + 'ServicoLog.txt') then
       Append(vLogFile)
     else
       Rewrite(vLogFile);
     Writeln(vLogFile, DateTimeToStr(Now) + ': [ID: ' + pIdPedido.ToString + '] '
                          + pMensagem);
     CloseFile(vLogFile);
  end;

begin
  try
    if pIdPedido > 0 then
    begin
      FQuery.Close;
      FQuery.SQL.Text := 'INSERT INTO LOG_PROCESSAMENTO (ID_PEDIDO, MENSAGEM, DATA_LOG) '+
                             'VALUES (:ID_PEDIDO, :MENSAGEM, CURRENT_TIMESTAMP)';
      FQuery.ParamByName('ID_PEDIDO').AsInteger := pIdPedido;
      FQuery.ParamByName('MENSAGEM').AsString := pMensagem;
      FQuery.ExecSQL;
    end
    else
     salvaLogTxt('');

  except
    on E: Exception do
      salvaLogTxt('(Erro ao registrar no banco: ' + E.Message + ')');

  end;
end;

initialization

finalization
  TDataPedidos.DestroyInstance;

end.
