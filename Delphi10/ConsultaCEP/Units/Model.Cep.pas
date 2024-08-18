unit Model.Cep;

interface
uses
  Rotina, FireDAC.Comp.Client;
type
  TCepModel = class
  private
    FAcao: TAcao;
    FCodigo: Integer;
    FCep: string;
    FLogradouro: string;
    FComplemento: string;
    FBairro: string;
    FLocalidade: string;
    FUf: string;
    procedure SetCodigo(const Value: Integer);
    procedure SetCep(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetBairro(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetUf(const Value: string);
    procedure SetAcao(const Value: TAcao);
  public
    function Obter: TFDQuery;
    function Salvar: Boolean;
    function Existe(ACep: string): Boolean;
    property Codigo: Integer read FCodigo write SetCodigo;
    property Cep: string read FCep write SetCep;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Complemento: string read FComplemento write SetComplemento;
    property Bairro: string read FBairro write SetBairro;
    property Localidade: string read FLocalidade write SetLocalidade;
    property Uf: string read FUf write SetUf;
    property Acao: TAcao read FAcao write SetAcao;
  end;

implementation

{ TCepModel }

uses Dao.Cep;

function TCepModel.Existe(ACep: string): Boolean;
var
  VCepDao: TCepDao;
begin
  VCepDao := TCepDao.Create;
  try
    Result := VCepDao.Existe(ACep);
  finally
    VCepDao.Free;
  end;
end;


function TCepModel.Obter: TFDQuery;
var
  VCepDao: TCepDao;
begin
  VCepDao := TCepDao.Create;
  try
    Result := VCepDao.Obter;
  finally
    VCepDao.Free;
  end;
end;

function TCepModel.Salvar: Boolean;
var
  VCepDao: TCepDao;
begin
  Result := False;
  VCepDao := TCepDao.Create;
  try
    case FAcao of
      Rotina.tacIncluir: Result := VCepDao.Incluir(Self);
      Rotina.tacAlterar: Result := VCepDao.Alterar(Self);
      Rotina.tacExcluir: Result := VCepDao.Excluir(Self);
    end;
  finally
    VCepDao.Free;
  end;
end;

procedure TCepModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;


procedure TCepModel.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TCepModel.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TCepModel.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TCepModel.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TCepModel.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TCepModel.SetUf(const Value: string);
begin
  FUf := Value;
end;

procedure TCepModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;


end.
