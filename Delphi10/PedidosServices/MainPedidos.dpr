program MainPedidos;

uses
  Vcl.Forms,
  Vcl.SvcMgr,
  System.SysUtils,
  PedidosServices in 'PedidosServices.pas' {Pedidos: TService},
  Data.Pedidos in 'data\Data.Pedidos.pas',
  Status.StatusPedido in 'Status\Status.StatusPedido.pas',
  Util.Conexao in 'Util\Util.Conexao.pas',
  Util.Sistema in 'Util\Util.Sistema.pas',
  DebugForm in 'DebugForm.pas' {Form1};

{$R *.RES}


begin

  // Modo serviço
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TPedidos, Pedidos);
  Application.Run;


end.
