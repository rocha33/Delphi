unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Control.Sistema,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MySQL;

type
  TfrmPrincipal = class(TForm)
    mnuPrincipal: TMainMenu;
    Cadastros: TMenuItem;
    mnuSair: TMenuItem;
    imgFundo: TImage;
    mnuConsultaCEP: TMenuItem;
    N1: TMenuItem;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    mnuSobre: TMenuItem;
    StatusBar1: TStatusBar;
    procedure SobreExecute(Sender: TObject);
    procedure ConsultarCEPExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SobreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmPrincipal: TfrmPrincipal;
  Usuario: Integer;

implementation

uses
  View.Sobre, View.ConsultarCEP, Control.Conexao;
{$R *.dfm}

procedure TfrmPrincipal.ConsultarCEPExecute(Sender: TObject);
begin
  if not (TfrmConsultarCep = nil) then
  begin
    Application.CreateForm(TfrmConsultarCep, frmConsultarCep);
    frmConsultarCEP.Show;
  end;
end;

procedure TfrmPrincipal.SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.SobreExecute(Sender: TObject);
begin
  if not (TfrmSobre = nil) then
  begin
    Application.CreateForm(TfrmSobre, frmSobre);
    frmSobre.Show;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Usuario := 1; // controle por usuario
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  TSistemaControl.GetInstance().Destroy();
end;

procedure TfrmPrincipal.SobreClick(Sender: TObject);
begin
  if not (TfrmSobre = nil) then
  begin
    Application.CreateForm(TfrmSobre, frmSobre);
    frmSobre.Show;
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
