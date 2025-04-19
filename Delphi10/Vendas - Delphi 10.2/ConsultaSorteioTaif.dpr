program ConsultaSorteioTaif;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  DataAccess in 'DataAccess.pas',
  modelCliente in 'models\modelCliente.pas',
  modelCarros in 'models\modelCarros.pas',
  modelVenda in 'models\modelVenda.pas',
  ServiceCarro in 'services\ServiceCarro.pas',
  ServiceCliente in 'services\ServiceCliente.pas',
  ServiceVenda in 'services\ServiceVenda.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
