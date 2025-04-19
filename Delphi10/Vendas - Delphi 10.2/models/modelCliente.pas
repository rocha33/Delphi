unit modelCliente;

interface

type
  TCliente = class
  private
    FCPF: string;
    FNome: string;
  public
    property CPF: string read FCPF write FCPF;
    property Nome: string read FNome write FNome;
  end;

implementation

end.

