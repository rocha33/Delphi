program ServerHorse;

{$APPTYPE CONSOLE}

{$R *.res}
// Desenvolvido por Valdecir
uses
  System.SysUtils, Horse, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys.MSSQL, System.JSON,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Async;

var
  FDConnection: TFDConnection;

function InitializeDatabase: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.DriverName := 'MySQL'; // usei mysql mas se for usar SQL tera q alterar alguns selects vai esta comentado abaixo
  Result.Params.Database := 'test';
  Result.Params.UserName := 'root';
  Result.Params.Password := '';
  Result.Params.Add('Server=localhost');
  Result.Connected := True;
end;

procedure ListTasks(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  vTasks: TJSONArray;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := FDConnection;
    vQuery.SQL.Text := 'SELECT * FROM Tasks';
    vQuery.Open;
    vTasks := TJSONArray.Create;
    while not vQuery.Eof do
    begin
      vTasks.AddElement(
        TJSONObject.Create
          .AddPair('TaskID', TJSONNumber.Create(vQuery.FieldByName('TaskID').AsInteger))
          .AddPair('Title', vQuery.FieldByName('Title').AsString)
          .AddPair('Description', vQuery.FieldByName('Description').AsString)
          .AddPair('Status', vQuery.FieldByName('Status').AsString)
          .AddPair('Priority', TJSONNumber.Create(vQuery.FieldByName('Priority').AsInteger))
          .AddPair('CreatedAt', vQuery.FieldByName('CreatedAt').AsString)
          .AddPair('UpdatedAt', vQuery.FieldByName('UpdatedAt').AsString)
      );
      vQuery.Next;
    end;
    Res.Send(vTasks.ToString);
  finally
    vQuery.Free;
  end;
end;

procedure AddTarefa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  vBody: TJSONObject;
  vJsonString: string;
begin
  vJsonString := Req.RawWebRequest.Content; // pega o conteudo do json
  if vJsonString.Trim.IsEmpty then
  begin
    Res.Status(400).Send('Corpo da requisi��o vazio');
    Exit;
  end;

  try
    vBody := TJSONObject.ParseJSONValue(vJsonString) as TJSONObject;
  except
    on E: Exception do
    begin
      Res.Status(400).Send('Formato de corpo da requisi��o inv�lido');
      Exit;
    end;
  end;

  vQuery := TFDQuery.Create(nil);
  try
    if Assigned(vBody) then
    begin

      vQuery.SQL.Text := 'INSERT INTO Tasks (Title, Description, Status, Priority) '+
                                     ' VALUES (:Title, :Description, :Status, :Priority)';

      vQuery.ParamByName('Title').AsString       := vBody.GetValue('Title').Value;
      vQuery.ParamByName('Description').AsString := vBody.GetValue('Description').Value;
      vQuery.ParamByName('Status').AsString      := vBody.GetValue('Status').Value;
      vQuery.ParamByName('Priority').AsInteger   := vBody.GetValue('Priority').Value.ToInteger;
      vQuery.ExecSQL;
      Res.Status(200).Send('Tarefa adicionada com successo.');
    end
    else
    begin
      Res.Status(400).Send('Corpo da requisi��o vazio ou formato inv�lido');
    end;


  finally
    vQuery.Free;
  end;
end;

procedure UpdateTarefaStatus(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  TaskID: Integer;
  Status: String;
begin

  vQuery := TFDQuery.Create(nil);
  try
    TaskID := Req.Params['id'].ToInteger;
    Status := Req.Params['status'];
    if TaskID > 0 then
    begin
      vQuery.Connection := FDConnection;                        // se for sql mudar now() para DATEADD
      vQuery.SQL.Text := 'UPDATE Tasks SET Status = :Status, UpdatedAt = Now() WHERE TaskID = :TaskID';
      vQuery.ParamByName('Status').AsString := Status;
      vQuery.ParamByName('TaskID').AsInteger := TaskID;
      vQuery.ExecSQL;
      Res.Send('Atualizado com sucesso');
    end
    else
      Res.Send('Falha ao mudar status');

  finally
    vQuery.Free;
  end;
end;

procedure RemoveTarefa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  TaskID: Integer;
begin

  vQuery := TFDQuery.Create(nil);
  try
    TaskID := Req.Params['id'].ToInteger;
    if TaskID > 0 then
    begin
      vQuery.Connection := FDConnection;
      vQuery.SQL.Text := 'DELETE FROM Tasks WHERE TaskID = :TaskID';
      vQuery.ParamByName('TaskID').AsInteger := TaskID;
      vQuery.ExecSQL;
      Res.Send('Tarefa removida com successo.');
    end
    else
      Res.Send('N�o foi poss�vel remover.');

  finally
    vQuery.Free;
  end;
end;

procedure GetTotalTarefas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  TotalTasks: Integer;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := FDConnection;
    vQuery.SQL.Text := 'SELECT COUNT(*) AS TotalTasks FROM Tasks';
    vQuery.Open;
    TotalTasks := vQuery.FieldByName('TotalTasks').AsInteger;
    Res.Send(inttoStr(TotalTasks));
  finally
    vQuery.Free;
  end;
end;

procedure GetPendingPriority(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  vPriority: integer;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vPriority := 0;
    vQuery.Connection := FDConnection;
    vQuery.SQL.Text := 'SELECT  COUNT(*) AS pPriority FROM Tasks WHERE Status = "Pendente"';
    vQuery.Open;
    vPriority := vQuery.FieldByName('pPriority').AsInteger;
    Res.Send(inttoStr(vPriority));
  finally
    vQuery.Free;
  end;
end;

procedure GetCompletedTasksLast7Days(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vQuery: TFDQuery;
  CompletedTasks: Integer;
begin
  vQuery := TFDQuery.Create(nil);
  try                                                                                              //se sql usar UpdatedAt >= DATEADD(day, -7, GETDATE())
    vQuery.Connection := FDConnection;
    vQuery.SQL.Text := 'SELECT COUNT(*) AS CompletedTasks FROM Tasks WHERE Status = "Completo" AND UpdatedAt >= DATE_SUB(NOW(), INTERVAL 7 DAY)';
    vQuery.Open;
    CompletedTasks := vQuery.FieldByName('CompletedTasks').AsInteger;
    Res.Send(inttoStr(CompletedTasks));
  finally
    vQuery.Free;
  end;
end;

procedure SetupRoutes;
begin
  THorse.Get('/ping',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  begin
    Res.Send('pong');
  end);
  // Rota para manipular as tarefa
  THorse.Post('/tasks',AddTarefa);
  THorse.Get('/ListTasks', ListTasks);
  THorse.Get('/GetCompletedTasksLast7Days', GetCompletedTasksLast7Days);
  THorse.Get('/GetPendingPriority', GetPendingPriority);
  THorse.Get('/totalTarefas', GetTotalTarefas);
  THorse.Put('/UpdateTarefaStatus/:id/status/:status', UpdateTarefaStatus);
  THorse.Delete('/tasksDel/:id', RemoveTarefa);

end;

begin
  try
    FDConnection := InitializeDatabase;
    SetupRoutes;
    THorse.Listen(9000);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
