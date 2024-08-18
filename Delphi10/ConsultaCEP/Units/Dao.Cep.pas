unit Dao.Cep;

interface
uses
  FireDAC.Comp.Client, Control.Conexao, Model.Cep, System.SysUtils, Vcl.Dialogs;
type
  TCepDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function Obter: TFDQuery;
    function Incluir(pCepModel: TCepModel): Boolean;
    function Alterar(pCepModel: TCepModel): Boolean;
    function Excluir(pCepModel: TCepModel): Boolean;
    function Existe(ACep: string): Boolean;
  end;
implementation

{ TCepDao }

uses Control.Sistema, View.Principal;

function TCepDao.Alterar(pCepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update cep set logradouro = :logradouro, complemento = :complemento,'+
                              'bairro = :bairro, localidade = :localidade, uf =:uf , usuario=:usuario '  +
                 'where (cep = :cep)', [pCepModel.Logradouro, pCepModel.Complemento,
                               pCepModel.Bairro, pCepModel.Localidade, pCepModel.Uf, pCepModel.Cep, View.Principal.Usuario]);
    Result := True;
  finally
    VQry.Free;
  end;
end;

constructor TCepDao.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TCepDao.Excluir(pCepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete cep where (codigo = :codigo)', [pCepModel.Codigo]);
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TCepDao.Existe(ACep: string): Boolean;
var
  VQry: TFDQuery;
begin
  Result := False;
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('select cep from cep where (cep = :cep)', [ACep]);

    if VQry.RecordCount > 0 then
      Result := True;
  finally
    VQry.Free;
  end;
end;


function TCepDao.Incluir(pCepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into cep (cep,  logradouro,  complemento,  bairro,  localidade,  uf,  usuario) ' +
                          'values (:cep, :logradouro, :complemento, :bairro, :localidade, :uf, :usuario) ',
                 [pCepModel.Cep, pCepModel.Logradouro, pCepModel.Complemento,
                 pCepModel.Bairro, pCepModel.Localidade, pCepModel.Uf, View.Principal.Usuario]);
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TCepDao.Obter: TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  VQry.Open('select codigo, cep, logradouro, complemento, bairro, localidade, uf from cep order by datahoraalteracao');
  Result := VQry;
end;

end.
