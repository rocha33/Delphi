unit modelVenda;

interface

uses System.SysUtils;

type
  TVenda = class
  private
    FIDVenda: Integer;
    FCPFCliente: string;
    FModeloCarro: string;
    FDataVenda: TDate;
  public
    property IDVenda: Integer read FIDVenda write FIDVenda;
    property CPFCliente: string read FCPFCliente write FCPFCliente;
    property ModeloCarro: string read FModeloCarro write FModeloCarro;
    property DataVenda: TDate read FDataVenda write FDataVenda;
  end;

implementation

end.

