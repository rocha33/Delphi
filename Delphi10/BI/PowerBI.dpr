program PowerBI;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Principal},
  Rotinas in 'Rotinas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
