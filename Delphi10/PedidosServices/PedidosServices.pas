unit PedidosServices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, Util.Sistema, Util.Conexao,
  FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Vcl.ExtCtrls, Status.StatusPedido,Data.Pedidos;

type
  TPedidos = class(TService)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    timerPedidos: TTimer;
    procedure ServiceCreate(Sender: TObject);
    procedure timerPedidosTimer(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
    FConexao: TConexao;
    procedure ProcessarPedidos;

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Pedidos: TPedidos;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Pedidos.Controller(CtrlCode);
end;

function TPedidos.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TPedidos.ServiceCreate(Sender: TObject);
begin
  //reforcei a conexão a library
  FDPhysFBDriverLink1 := TFDPhysFBDriverLink.Create(nil);
end;

procedure TPedidos.ServiceStart(Sender: TService; var Started: Boolean);
begin
  try
    timerPedidos.Interval := 10000; // 10 segundos
    timerPedidos.Enabled := True;
    TDataPedidos.Instance.RegistrarLog(0, 'Serviço iniciado com sucesso.');
    Started := True;
  except
    on E: Exception do
    begin
      TDataPedidos.Instance.RegistrarLog(0, 'Erro ao iniciar o serviço: ' + E.Message);
      Started := False;
    end;
  end;
end;

procedure TPedidos.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  try
    timerPedidos.Enabled := False;
    TDataPedidos.Instance.RegistrarLog(0, 'Serviço parado com sucesso.');
    Stopped := True;
  except
    on E: Exception do
    begin
      TDataPedidos.Instance.RegistrarLog(0, 'Erro ao parar o serviço: ' + E.Message);
      Stopped := False;
    end;
  end;
end;

procedure TPedidos.timerPedidosTimer(Sender: TObject);
begin
  timerPedidos.Enabled := False;
  try
    ProcessarPedidos;
  finally
    timerPedidos.Enabled := True;
  end;
end;

procedure TPedidos.ProcessarPedidos;
var
  PedidoIds: TArray<Integer>;
  Id: Integer;
  Pedido: TPedidoContext;
begin
  try
    // Busca pedidos no estado AGUARDANDO
    PedidoIds := TDataPedidos.Instance.BuscarPedidosAguardando;
    for Id in PedidoIds do
    begin
      try
        Pedido := TPedidoContext.Create(Id);
        try
          Pedido.Processar;
        finally
          Pedido.Free;
        end;
      except
        on E: Exception do
        begin
          TDataPedidos.Instance.RegistrarLog(Id, 'Erro ao processar pedido: ' + E.Message);
          // Garante que o serviço continue processando os próximos pedidos
        end;
      end;
    end;
    if Length(PedidoIds) = 0 then
      TDataPedidos.Instance.RegistrarLog(0, 'Nenhum pedido aguardando');
  except
    on E: Exception do
    begin
      TDataPedidos.Instance.RegistrarLog(0, 'Erro ao buscar pedidos: ' + E.Message);
    end;
  end;
end;

end.
