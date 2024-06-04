unit TarefasForms;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Client, REST.Types, System.JSON,
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ComCtrls,
  Vcl.Grids,System.Net.HttpClient;


type
  TfrmMain = class(TForm)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    lblQtdTarefas1: TLabel;
    lblQtdTarefas: TLabel;
    Label1: TLabel;
    lblQtdTarefasPriority: TLabel;
    pgcPrincipal: TPageControl;
    tsListasTarefas: TTabSheet;
    btnRemovertarefa: TButton;
    StringGridListas: TStringGrid;
    EditTitle: TEdit;
    MemoDescription: TMemo;
    btnAddTarefa: TButton;
    btnMudarstatus: TButton;
    cbbStatus: TComboBox;
    procedure btnAddTarefaClick(Sender: TObject);
    procedure btnRemovertarefaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMudarstatusClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListarTarefas;
    procedure GetTotais();
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
  uses TarefasFuncoes;

{$R *.dfm}

procedure TfrmMain.btnAddTarefaClick(Sender: TObject);
var
  TaskData: TJSONObject;
  vTarefasFuncoes: TTarefasFuncoes;
begin
  vTarefasFuncoes:= TTarefasFuncoes.create;
  try
    if(vTarefasFuncoes.AddTarefa(EditTitle.Text, MemoDescription.Text))then
      ListarTarefas();
  finally
    FreeAndNil(vTarefasFuncoes);
  end;
end;

procedure TfrmMain.ListarTarefas;
var
  Tasks: TJSONArray;
  Task: TJSONObject;
  i, Row: Integer;

  vTarefasFuncoes: TTarefasFuncoes;
begin
  vTarefasFuncoes:= TTarefasFuncoes.create;
  try
    Tasks := vTarefasFuncoes.ListarTarefas();

  finally
    FreeAndNil(vTarefasFuncoes);
  end;

  StringGridListas.RowCount := Tasks.Count + 1; // Número de tarefas + cabeçalho

  // Preencher o grid com os dados das tarefas
  for i := 0 to Tasks.Count - 1 do
  begin
    Task := Tasks.Items[i] as TJSONObject;
    Row := i + 1; // Primeira linha de dados

    StringGridListas.Cells[0, Row] := Task.GetValue('TaskID').Value;
    StringGridListas.Cells[1, Row] := Task.GetValue('Title').Value;
    StringGridListas.Cells[2, Row] := Task.GetValue('Description').Value;
    StringGridListas.Cells[3, Row] := Task.GetValue('Status').Value;
    StringGridListas.Cells[4, Row] := Task.GetValue('Priority').Value;
    StringGridListas.Cells[5, Row] := Task.GetValue('CreatedAt').Value;
    StringGridListas.Cells[6, Row] := Task.GetValue('UpdatedAt').Value;
  end;
end;

procedure TfrmMain.btnRemovertarefaClick(Sender: TObject);
var
  TaskID: string;
  vTarefasFuncoes: TTarefasFuncoes;
begin
  vTarefasFuncoes:= TTarefasFuncoes.create;
  try
    TaskID := StringGridListas.Cells[0, StringGridListas.Row];

    if(TaskID <> '') and (vTarefasFuncoes.RemoverTarefa(TaskID))then
    begin
      GetTotais();
    end;

  finally
    FreeAndNil(vTarefasFuncoes);
  end;

end;

procedure TfrmMain.GetTotais();
var vTarefasFuncoes: TTarefasFuncoes;
begin
  vTarefasFuncoes:= TTarefasFuncoes.create;
  try
    lblQtdTarefas.caption := intToStr(vTarefasFuncoes.GetTotalTarefas());
    lblQtdTarefasPriority.caption := intToStr(vTarefasFuncoes.GetPriorityTarefas());
    ListarTarefas();
  finally
    FreeAndNil(vTarefasFuncoes);
  end;
end;
procedure TfrmMain.btnMudarstatusClick(Sender: TObject);
var
  vTaskID: string;
  vNewStatus: string;
  vTarefasFuncoes: TTarefasFuncoes;
begin
  vTaskID := StringGridListas.Cells[0, StringGridListas.Row];
  if Trim(vTaskID) = '' then
  begin
    ShowMessage('Nenhuma tarefa selecionada.');
    Exit;
  end;

  // Supondo que você tem um campo ou variável para o novo status
  vNewStatus := cbbStatus.text; // Altere conforme necessário

  vTarefasFuncoes:= TTarefasFuncoes.create;
  try
    if(vTarefasFuncoes.UpdateStatus(vTaskID, vNewStatus))then
      GetTotais();
  finally
    FreeAndNil(vTarefasFuncoes);
  end;

end;


procedure TfrmMain.FormCreate(Sender: TObject);
var vTarefasFuncoes: TTarefasFuncoes;
begin
  StringGridListas.ColCount := 6;
  StringGridListas.Cells[0, 0] := 'TaskID';
  StringGridListas.Cells[1, 0] := 'Title';
  StringGridListas.Cells[2, 0] := 'Description';
  StringGridListas.Cells[3, 0] := 'Status';
  StringGridListas.Cells[4, 0] := 'Priority';
  StringGridListas.Cells[5, 0] := 'CreatedAt';

  GetTotais();
  ListarTarefas();

end;

end.
