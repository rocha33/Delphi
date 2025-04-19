unit modelCarros;

interface

type
  TCarro = class
  private
    FModelo: string;
    FAnoLancamento: Integer;
  public
    property Modelo: string read FModelo write FModelo;
    property AnoLancamento: Integer read FAnoLancamento write FAnoLancamento;
  end;

implementation

end.

