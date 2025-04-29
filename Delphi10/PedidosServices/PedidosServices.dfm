object Pedidos: TPedidos
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'Pedidos pendentes'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 444
  Width = 654
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 96
    Top = 72
  end
  object timerPedidos: TTimer
    OnTimer = timerPedidosTimer
    Left = 208
    Top = 65
  end
end
