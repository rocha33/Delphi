program ConsultaCep;

uses
  Vcl.Forms,
  View.frmBase in '..\Units\View.frmBase.pas' {frmBase},
  View.Sobre in '..\Units\View.Sobre.pas' {frmSobre},
  View.ConsultarCEP in '..\Units\View.ConsultarCEP.pas' {frmConsultarCEP},
  Control.Conexao in '..\Units\Control.Conexao.pas',
  model.Cep in '..\Units\model.Cep.pas',
  Dao.Cep in '..\Units\Dao.Cep.pas',
  Control.Cep in '..\Units\Control.Cep.pas',
  Control.Sistema in '..\Units\Control.Sistema.pas',
  View.Principal in '..\Units\View.Principal.pas' {frmPrincipal},
  Rotina in '..\Units\Rotina.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
