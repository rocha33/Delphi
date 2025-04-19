unit Principal;

{
  Projeto Avaliação Técnica - Delphi

  Autor: Valdecir Rocha
  Descrição:
    Este projeto foi estruturado com base no princípio SRP (Single Responsibility Principle),
    separando claramente as responsabilidades entre camada de modelo (dados), serviço (regras de negócio)
    e apresentação (interface). O código implementa a inserção de clientes, carros, vendas e
    consultas SQL simuladas.

  Data: [12/04/2025]
}


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ServiceCarro, ServiceVenda, ServiceCliente,
  Vcl.StdCtrls, modelCliente, modelVenda, modelCarros;

type
  TfrmPrincipal = class(TForm)
    btnIncluir: TButton;
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    function SalvarVenda(pClinte: array of TCliente; pCarro: array of TCarro): Boolean;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnIncluirClick(Sender: TObject);
const arrayNomes  : array[0..4] of string = ('Maria Tereza',
                                         'Abacate Silva',
                                         'João Silva',
                                         'José Alves',
                                         'Maria Conceição');
var
  ClienteService: TClienteService;
  listClientes: array[0..4] of TCliente;

  listaCarros: array[0..4] of TCarro;
  vCarroService : TCarroService;

  vVenda : array of TVenda;

  I: Integer;
begin
  ClienteService := TClienteService.Create;
  vCarroService := TCarroService.Create;
  try
    FillChar(listClientes, SizeOf(listClientes), 0);
    FillChar(listaCarros, SizeOf(listaCarros), 0);
    // 2 – Criar uma funcionalidade para inserir 5 novos clientes.
    for I := 0 to Length(listClientes)-1 do
    begin
      listClientes[I] := TCliente.Create;
      listClientes[I].Nome := arrayNomes[I];
      listClientes[I].CPF := Format('0%d0000000', [I + 1]);
    end;

     // 3 – Criar uma funcionalidade para inserir 5 modelos de carros novos.
    for I := 0 to Length(listaCarros) - 1 do
    begin
      listaCarros[I] := TCarro.Create;
      listaCarros[I].Modelo := 'Modelo ' + IntToStr(I + 1);
      listaCarros[I].AnoLancamento := 2021;
    end;

    // Simulação de persistência em banco via método fictício InserirCliente/InserirCarros.
    if(ClienteService.InserirCliente(listClientes)) and (vCarroService.InserirCarros(listaCarros)) then
      SalvarVenda(listClientes, listaCarros);

  finally
    // limpa as instancias
    for I := 0 to Length(listClientes) - 1 do
      if Assigned(listClientes[I]) then
        listClientes[I].Free;

    for I := 0 to Length(listaCarros) - 1 do
      if Assigned(listaCarros[I]) then
        listaCarros[I].Free;

    vCarroService.Free;
    ClienteService.Free;

  end;
end;


function TfrmPrincipal.SalvarVenda(pClinte: array of TCliente; pCarro: array of TCarro): Boolean;
var
  VendaService: TVendaService;
  vVenda : array of TVenda;
  I: Integer;
  vQtdItensClientes: Integer;
begin
  //4 – Criar uma funcionalidade para inserir uma venda para os 5 novos clientes
  // inseridos(cada um com um modelo de carro diferente).
  Result := False;
  VendaService := TVendaService.Create;
  try
    vQtdItensClientes := Length(pClinte);
    SetLength(vVenda, vQtdItensClientes);
    for I := 0 to vQtdItensClientes - 1 do
    begin
      vVenda[I] := TVenda.Create; // ← importante!
      vVenda[I].CPFCliente := pClinte[I].CPF;
      vVenda[I].ModeloCarro:= pCarro[I].Modelo;
    end;

    if(VendaService.InserirVenda(vVenda))then
    begin
      ShowMessage(IntToStr(Length(pClinte))+ ' vendas realizadas com sucesso!');
      Result := True;
    end;

  finally
    for I := 0 to Length(vVenda) - 1 do
      if Assigned(vVenda[I]) then
        vVenda[I].Free;

    VendaService.Free;
  end;
end;

end.
