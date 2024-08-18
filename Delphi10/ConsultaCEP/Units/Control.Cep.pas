unit Control.Cep;

interface
uses
  model.Cep, System.SysUtils, FireDAC.Comp.Client;
type
  TCepControl = class
  private
    FCepModel: TCepModel;
  public
    constructor Create;
    destructor Destroy; override;
    function Salvar: Boolean;
    function Obter: TFDQuery;
    function Existe(pCep: string): Boolean;
    property CepModel: TCepModel read FCepModel write FCepModel;
  end;

implementation

{ TCepControl }

constructor TCepControl.Create;
begin
  FCepModel := TCepModel.Create;
end;

destructor TCepControl.Destroy;
begin
  FCepModel.Free;
  inherited;
end;

function TCepControl.Existe(pCep: string): Boolean;
begin
  Result := FCepModel.Existe(pCep);
end;

function TCepControl.Obter: TFDQuery;
begin
  Result := FCepModel.Obter;
end;

function TCepControl.Salvar: Boolean;
begin
  Result := FCepModel.Salvar;
end;
end.
