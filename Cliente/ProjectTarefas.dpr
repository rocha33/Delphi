program ProjectTarefas;

uses
  Vcl.Forms,
  TarefasForms in 'TarefasForms.pas' {frmMain},
  TarefasFuncoes in 'TarefasFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
