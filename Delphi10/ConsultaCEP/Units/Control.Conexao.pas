unit Control.Conexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait,
  Vcl.Forms;

type
  TConexao = class
  private
    FConnection: TFDConnection;
    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;

    function GetConn: TFDConnection;
    function CriarQuery: TFDQuery;
  end;

implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin

  FConnection.DriverName := 'MySQL';
  FConnection.Params.Values['Server']    := 'localhost'; // Endere�o do servidor
  FConnection.Params.Values['Database']  := 'vendadb'; // Nome do banco de dados
  FConnection.Params.Values['User_Name'] := 'root'; // Nome de usu�rio do banco de dados
  FConnection.Params.Values['Password']  := ''; // Senha do banco de dados
  FConnection.Params.Values['Port']      := '3306'; // Porta do servidor MySQL
  FConnection.LoginPrompt := False; // Desabilitar prompt de login
  FConnection.Connected := True;  // Abre a conex�o

end;

constructor TConexao.Create;
begin
  FConnection := TFDConnection.Create(nil);

  Self.ConfigurarConexao();
end;

function TConexao.CriarQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := TFDQuery.Create(nil);
  VQuery.Connection := FConnection;

  Result := VQuery;
end;

destructor TConexao.Destroy;
begin
  FConnection.Free;

  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConnection;
end;

end.