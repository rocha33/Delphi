unit View.ConsultarCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  View.frmBase, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.UITypes, Control.Cep, Model.Cep,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.JSON, System.Net.HttpClient, System.Net.URLClient, IPPeerClient,
  Xml.Win.msxmldom, Vcl.Buttons;

type
  TfrmConsultarCEP = class(TfrmBase)
    dsCEPCadastrado: TDataSource;
    rdgMetodo: TRadioGroup;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    fdTempConsulta: TFDMemTable;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dbgCepCadastrados: TDBGrid;
    dbgRetornoConsulta: TDBGrid;
    fdCepCadastrado: TFDMemTable;
    dsRetornoConsulta: TDataSource;
    fdTempConsultacep: TWideStringField;
    fdTempConsultalogradouro: TWideStringField;
    fdTempConsultacomplemento: TWideStringField;
    fdTempConsultaunidade: TWideStringField;
    fdTempConsultabairro: TWideStringField;
    fdTempConsultalocalidade: TWideStringField;
    fdTempConsultauf: TWideStringField;
    fdTempConsultaibge: TIntegerField;
    fdTempConsultagia: TIntegerField;
    fdTempConsultaddd: TIntegerField;
    fdTempConsultasiafi: TIntegerField;
    XMLDocument1: TXMLDocument;
    SSLIO: TIdSSLIOHandlerSocketOpenSSL;
    btnPesquisa: TBitBtn;
    rdgCepLogradouro: TRadioGroup;
    Panel1: TPanel;
    lblCep: TLabel;
    lblComplemento: TLabel;
    lblLogradouro: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblUf: TLabel;
    edtCEP: TEdit;
    edtComplemento: TEdit;
    edtLogradouro: TEdit;
    edtBairro: TEdit;
    edtLocalidade: TEdit;
    edtUf: TEdit;
    btnSalvar: TBitBtn;
    procedure edtCEPEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgCepCadastradosDblClick(Sender: TObject);
    procedure dbgCepCadastradosCellClick(Column: TColumn);
    procedure edtLogradouroEnter(Sender: TObject);
    procedure dbgRetornoConsultaDblClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);

  private
    { Private declarations }
    FCepControl: TCepControl;
    procedure ConsultaCEP(ACep: string);
    procedure ConsultaCEP_Endereco(pUf, pLocalidade, pLogradouro: string);
    procedure PopulaCampos(pMemtable: TFDMemTable);
    procedure LimpaEdits;
    procedure IncluirCep(pMemtable: TFDMemTable);
    procedure AtualizaCep(pMemtable: TFDMemTable);
    procedure BuscarCeps;
    procedure PesquisaViaJson(const pResource: string);
    procedure ConsultaViaXML(pResource: string);
    procedure GravaRetorno;
  public
    { Public declarations }
  end;

const
  _BASE_URL_VIACEP = 'https://viacep.com.br/ws/';

var
  frmConsultarCEP: TfrmConsultarCEP;

implementation

uses
  Rotina;

{$R *.dfm}

procedure TfrmConsultarCEP.dbgCepCadastradosCellClick(Column: TColumn);
begin
  inherited;
  PopulaCampos(fdCepCadastrado);
end;

procedure TfrmConsultarCEP.dbgCepCadastradosDblClick(Sender: TObject);
begin
  inherited;
  PopulaCampos(fdCepCadastrado);
end;

procedure TfrmConsultarCEP.dbgRetornoConsultaDblClick(Sender: TObject);
begin
  inherited;
  if not dsRetornoConsulta.DataSet.IsEmpty then
  begin
    GravaRetorno;
    BuscarCeps;
  end;

end;

procedure TfrmConsultarCEP.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  if rdgCepLogradouro.ItemIndex = 0 then
    ConsultaCep(SoNumero(edtCEP.Text))
  else if rdgCepLogradouro.ItemIndex = 1 then
    ConsultaCEP_Endereco(edtUf.Text, edtLocalidade.Text, edtLogradouro.Text);
end;

procedure TfrmConsultarCEP.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if not dsRetornoConsulta.DataSet.IsEmpty then
  begin
    GravaRetorno;
    BuscarCeps;
  end;

end;

procedure TfrmConsultarCEP.edtCEPEnter(Sender: TObject);
begin
  inherited;
  if edtCEP.Text <> EmptyStr then
  begin
    LimpaEdits;
    fdTempConsulta.Close;
  end;
end;

procedure TfrmConsultarCEP.edtLogradouroEnter(Sender: TObject);
begin
  inherited;
  if edtCEP.Text <> EmptyStr then
  begin
    LimpaEdits;
    fdTempConsulta.Close;
  end;
end;

procedure TfrmConsultarCEP.FormCreate(Sender: TObject);
begin
  inherited;
  FCepControl := TCepControl.Create;
end;

procedure TfrmConsultarCEP.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCepControl);
end;

procedure TfrmConsultarCEP.FormShow(Sender: TObject);
begin
  inherited;
  BuscarCeps;
end;

procedure TfrmConsultarCEP.ConsultaCEP(ACep: string);
begin
  dsRetornoConsulta.DataSet.Close;
  if ACep.Length <> 8 then
  begin
    MessageDlg('CEP inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end;

  if rdgMetodo.ItemIndex = -1 then
  begin
    MessageDlg('Selecione um m�todo de consulta!', mtInformation, [mbOk], 0);
    rdgMetodo.SetFocus;
    Exit;
  end
  else if rdgMetodo.ItemIndex = 0 then
    PesquisaViaJson(ACep + '/json') //json
  else
    ConsultaViaXML(ACep + '/xml'); //XML

  BuscarCeps;
end;

procedure TfrmConsultarCEP.ConsultaCEP_Endereco(pUf, pLocalidade, pLogradouro: string);
begin
  //Valida parametros para consulta
  if pUf.Length < 2 then
  begin
    MessageDlg('Estado inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end
  else if pLocalidade.Length <= 3 then
  begin
    MessageDlg('Localidade inv�lida!', mtInformation, [mbOk], 0);
    Exit
  end
  else if pLogradouro.Length <= 3 then
  begin
    MessageDlg('Logradouro inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end;

  if rdgMetodo.ItemIndex = 0 then
    PesquisaViaJson(pUf + '/' + pLocalidade + '/' + pLogradouro + '/json')//json
  else
    ConsultaViaXML(pUf + '/' + pLocalidade + '/' + pLogradouro + '/xml'); //XML

  BuscarCeps;
end;

procedure TfrmConsultarCEP.PopulaCampos(pMemtable: TFDMemTable);
begin
  edtCEP.Text         := pMemtable.FieldByName('cep').AsString;
  edtLogradouro.Text  := pMemtable.FieldByName('logradouro').AsString;
  edtComplemento.Text := pMemtable.FieldByName('complemento').AsString;
  edtBairro.Text      := pMemtable.FieldByName('bairro').AsString;
  edtLocalidade.Text  := pMemtable.FieldByName('localidade').AsString;
  edtUf.Text          := pMemtable.FieldByName('uf').AsString;

end;

procedure TfrmConsultarCEP.IncluirCep(pMemtable: TFDMemTable);
var
  vCep: TCepModel;
begin
  vCep := FCepControl.CepModel;

  vCep.Acao        := Rotina.tacIncluir;
  vCep.Cep         := SoNumero(pMemtable.FieldByName('cep').AsString);
  vCep.Logradouro  := pMemtable.FieldByName('logradouro').AsString;
  vCep.Complemento := pMemtable.FieldByName('complemento').AsString;
  vCep.Bairro      := pMemtable.FieldByName('bairro').AsString;
  vCep.Localidade  := pMemtable.FieldByName('localidade').AsString;
  vCep.Uf          := pMemtable.FieldByName('uf').AsString;

  if FCepControl.CepModel.Salvar then
    MessageDlg('CEP cadastrado com sucesso.', mtConfirmation, [mbOk], 0);

end;

procedure TfrmConsultarCEP.AtualizaCep(pMemtable: TFDMemTable);
var
  vCep: TCepModel;
begin
  vCep := FCepControl.CepModel;

  vCep.Acao        := Rotina.tacAlterar;
  vCep.Cep         := SoNumero(pMemtable.FieldByName('cep').AsString);
  vCep.Logradouro  := pMemtable.FieldByName('logradouro').AsString;
  vCep.Complemento := pMemtable.FieldByName('complemento').AsString;
  vCep.Bairro      := pMemtable.FieldByName('bairro').AsString;
  vCep.Localidade  := pMemtable.FieldByName('localidade').AsString;
  vCep.Uf          := pMemtable.FieldByName('uf').AsString;

  if vCep.Salvar then
    MessageDlg('CEP Atualizado com sucesso.', mtConfirmation, [mbOk], 0);

end;

procedure TfrmConsultarCEP.BuscarCeps;
var
  VQry: TFDQuery;
begin
  fdCepCadastrado.Close;

  VQry := FCepControl.Obter;    
  try
    VQry.FetchAll;
    fdCepCadastrado.Data := VQry.Data;
  finally
    VQry.Close;
    FreeAndNil(VQry)
  end;
end;

procedure TfrmConsultarCEP.PesquisaViaJson(const pResource: string);
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONValue: TJSONValue;
  procedure SalvarDadosTemporario(const pJSONValue: TJSONValue);
  var
    i: Integer;
    JSONItem: TJSONObject;
    CepArray: TJSONArray;
  begin

    if pJSONValue is TJSONArray then
    begin
      // Extra��o dos dados em lista
      CepArray := TJSONArray(JSONValue);
      for i := 0 to CepArray.Count - 1 do
      begin
        JSONItem := CepArray.Items[i] as TJSONObject;
        fdTempConsulta.Close;
        fdTempConsulta.Open;
        fdTempConsulta.Append;
        fdTempConsulta.FieldByName('cep').AsString := JSONItem.GetValue<string>('cep');
        fdTempConsulta.FieldByName('logradouro').AsString := JSONItem.GetValue<string>('logradouro');
        fdTempConsulta.FieldByName('bairro').AsString := JSONItem.GetValue<string>('bairro');
        fdTempConsulta.FieldByName('localidade').AsString := JSONItem.GetValue<string>('localidade');
        fdTempConsulta.FieldByName('uf').AsString :=  JSONItem.GetValue<string>('uf');
        fdTempConsulta.FieldByName('complemento').AsString :=  JSONItem.GetValue<string>('complemento');
        fdTempConsulta.Post;
      end;

    end
    else if JSONValue is TJSONObject then
    begin
      // inserir dados temp
      fdTempConsulta.Close;
      fdTempConsulta.Open;
      fdTempConsulta.Append;
      fdTempConsulta.FieldByName('cep').AsString := TJSONObject(JSONValue).GetValue('cep').Value;
      fdTempConsulta.FieldByName('logradouro').AsString := TJSONObject(JSONValue).GetValue('logradouro').Value;
      fdTempConsulta.FieldByName('bairro').AsString := TJSONObject(JSONValue).GetValue('bairro').Value;
      fdTempConsulta.FieldByName('localidade').AsString := TJSONObject(JSONValue).GetValue('localidade').Value;
      fdTempConsulta.FieldByName('uf').AsString :=  TJSONObject(JSONValue).GetValue('uf').Value;
      fdTempConsulta.FieldByName('complemento').AsString :=  TJSONObject(JSONValue).GetValue('complemento').Value;
      fdTempConsulta.Post;
    end
    else
      MessageDlg('Resposta JSON inv�lida.', mtConfirmation, [mbOk], 0);

    if fdTempConsulta.RecordCount > 1 then
    begin
      MessageDlg('A consulta retornou mais de 1 registro!' + #10 + #13 +
               'Selecione na grid o registro deseja cadastrar, e bot�o salvar.', mtInformation, [mbok], 0 );
      dbgRetornoConsulta.SetFocus;
    end
    else if fdTempConsulta.RecordCount = 1 then
      GravaRetorno

  end;

begin

  if Trim(pResource) = '' then
    Exit;

  // Cria��o dos componentes REST
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    // Configura��o do cliente REST
    RESTClient.BaseURL   := _BASE_URL_VIACEP;
    RESTRequest.Client   := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method   := TRESTRequestMethod.rmGET;
    RESTRequest.Resource := pResource;

    // Executa a requisi��o
    RESTRequest.Execute;

    // Processa a resposta JSON
    if RESTResponse.StatusCode = 200 then
    begin
      JSONValue := TJSONObject.ParseJSONValue(RESTResponse.Content);
      try
        SalvarDadosTemporario(JSONValue);
      finally
        JSONValue.Free;
      end;
    end
    else
      MessageDlg('Erro ao consultar o CEP. Status Code: '+ IntToStr(RESTResponse.StatusCode), mtConfirmation, [mbOk], 0);

  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;
end;

procedure TfrmConsultarCEP.ConsultaViaXML(pResource: string);
var
  tempXML :IXMLNode;
  tempNodePAI :IXMLNode;
  tempNodeFilho :IXMLNode;
  I, ICountNodes :Integer;
begin
  XMLDocument1.FileName := _BASE_URL_VIACEP + pResource;
  XMLDocument1.Active := true;
  tempXML := XMLDocument1.DocumentElement;

  fdTempConsulta.Close;
  fdTempConsulta.Open;

  fdTempConsulta.Append;

  tempNodePAI := tempXML.ChildNodes.FindNode('cep');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('cep').AsString :=  SoNumero(tempNodeFilho.Text);
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('logradouro');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('logradouro').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('bairro');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('bairro').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('localidade');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('localidade').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('uf');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('uf').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('complemento');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('complemento').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('ibge');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('ibge').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('gia');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('gia').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('ddd');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('ddd').AsString :=  tempNodeFilho.Text;
  end;

  tempNodePAI := tempXML.ChildNodes.FindNode('siafi');
  for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
  begin
    tempNodeFilho := tempNodePAI.ChildNodes[i];
    fdTempConsulta.FieldByName('siafi').AsString :=  tempNodeFilho.Text;
  end;
  fdTempConsulta.Post;

  if fdTempConsulta.RecordCount = 1 then
    GravaRetorno
  else if fdTempConsulta.RecordCount > 1 then
  begin
    MessageDlg('A consulta retornou mais de 1 registro!' + #10 + #13 +
               'Selecione na grid o registro deseja cadastrar, e bot�o salvar.', mtInformation, [mbok], 0 );
    dbgRetornoConsulta.SetFocus;

  end;

end;

procedure TfrmConsultarCEP.GravaRetorno;
begin
  PopulaCampos(fdTempConsulta);
  if FCepControl.Existe(SoNumero(edtCEP.Text)) then
  begin
    if MessageDlg('Este CEP j� existe na base de dados, deseja atualizar?', mtInformation, [mbYes, mbNo], 0) = mrYes then
      AtualizaCep(fdTempConsulta);

  end
  else
    IncluirCep(fdTempConsulta);
end;

procedure TfrmConsultarCEP.LimpaEdits;
var
  i: integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEdit) then
      (Self.Components[i] as TEdit).text := '';
  end;
end;

end.