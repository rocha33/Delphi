unit Status.StatusPedido;

interface

uses
  System.SysUtils, System.Classes;

type
  // Estados possíveis do pedido
  TStatusPedido = (spAguardando, spProcessando, spConcluido, spFalha);

  // Interface para os estados
  IState = interface
    ['{A2D5E8C1-4F2B-4E7A-9C5D-6B8E9D0F1A2C}']
    function GetStatus: TStatusPedido;
    procedure Processar(const pIdPedido: Integer);
  end;

  // máquina de estados
  TPedidoContext = class
  private
    FState: IState;
    FIdPedido: Integer;
    procedure SetState(const AState: IState);
  public
    constructor Create(pIdPedido: Integer);
    procedure Processar;
    property State: IState read FState write SetState;
    property IdPedido: Integer read FIdPedido;
  end;

  // Classe base para os estados
  TStateBase = class(TInterfacedObject)
  private
    FContext: TPedidoContext;
  protected
    procedure Log(const AMensagem: string);
    procedure AtualizarStatus(const pStatus: TStatusPedido; const pDataProcessamento: TDateTime);
  public
    constructor Create(pContext: TPedidoContext);
    property Context: TPedidoContext read FContext;
  end;

  // Estado: AGUARDANDO
  TStateAguardando = class(TStateBase, IState)
  public
    function GetStatus: TStatusPedido;
    procedure Processar(const pIdPedido: Integer);
  end;

  // Estado: PROCESSANDO
  TStateProcessando = class(TStateBase, IState)
  public
    function GetStatus: TStatusPedido;
    procedure Processar(const pIdPedido: Integer);
  end;

  // Estado: CONCLUIDO
  TStateConcluido = class(TStateBase, IState)
  public
    function GetStatus: TStatusPedido;
    procedure Processar(const pIdPedido: Integer);
  end;

  // Estado: FALHA
  TStateFalha = class(TStateBase, IState)
  public
    function GetStatus: TStatusPedido;
    procedure Processar(const pIdPedido: Integer);
  end;

implementation

uses
  Data.Pedidos;

{ TPedidoContext }

constructor TPedidoContext.Create(pIdPedido: Integer);
begin
  FIdPedido := pIdPedido;
  FState := TStateAguardando.Create(Self);
end;

procedure TPedidoContext.Processar;
begin
  FState.Processar(FIdPedido);
end;

procedure TPedidoContext.SetState(const AState: IState);
begin
  FState := AState;
end;

{ TStateBase }

constructor TStateBase.Create(pContext: TPedidoContext);
begin
  FContext := pContext;
end;

procedure TStateBase.Log(const AMensagem: string);
begin
  // Registra o log no banco ou em arquivo (implementado em Data.Pedidos)
  TDataPedidos.Instance.RegistrarLog(FContext.IdPedido, AMensagem);
end;

procedure TStateBase.AtualizarStatus(const pStatus: TStatusPedido; const pDataProcessamento: TDateTime);
begin
  // Atualiza o status do pedido no banco (implementado em Data.Pedidos)
  TDataPedidos.Instance.AtualizarStatus(FContext.IdPedido, pStatus, pDataProcessamento);
end;

{ TStateAguardando }

function TStateAguardando.GetStatus: TStatusPedido;
begin
  Result := spAguardando;
end;

procedure TStateAguardando.Processar(const pIdPedido: Integer);
begin
  Log('Iniciando processamento do pedido ' + pIdPedido.ToString);
  // se tiver aguardando chama o processando
  Context.State := TStateProcessando.Create(Context);
  Context.Processar;
end;

{ TStateProcessando }

function TStateProcessando.GetStatus: TStatusPedido;
begin
  Result := spProcessando;
end;

procedure TStateProcessando.Processar(const pIdPedido: Integer);
begin
  try
    Log('Processando pedido ' + pIdPedido.ToString);
    // Simula o processamento
    Sleep(2000);
    // Atualiza o status para PROCESSANDO
    AtualizarStatus(spProcessando, Now);
    // após isso chama o concluido
    Context.State := TStateConcluido.Create(Context);
    Context.Processar;
  except
    on E: Exception do
    begin
      Log('Erro ao processar pedido ' + pIdPedido.ToString + ': ' + E.Message);
      // Transição: PROCESSANDO -> FALHA
      Context.State := TStateFalha.Create(Context);
      Context.Processar;
    end;
  end;
end;

{ TStateConcluido }

function TStateConcluido.GetStatus: TStatusPedido;
begin
  Result := spConcluido;
end;

procedure TStateConcluido.Processar(const pIdPedido: Integer);
begin

  Log('Pedido ' + pIdPedido.ToString + ' concluído com sucesso');
  AtualizarStatus(spConcluido, Now);
  // Não há transição, estado final
end;

{ TStateFalha }

function TStateFalha.GetStatus: TStatusPedido;
begin
  Result := spFalha;
end;

procedure TStateFalha.Processar(const pIdPedido: Integer);
begin
  Log('Pedido ' + pIdPedido.ToString + ' movido para estado FALHA');
  AtualizarStatus(spFalha, Now);
end;

end.
