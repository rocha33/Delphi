unit View.Sobre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Winapi.ShellAPI,
  Vcl.StdCtrls, View.frmBase;

type
  TfrmSobre = class(TfrmBase)
    Panel1: TPanel;
    Label1: TLabel;
    LinkLabel1: TLinkLabel;
    LinkLabel2: TLinkLabel;
    procedure LinkLabel1Click(Sender: TObject);
    procedure LinkLabel2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.dfm}

procedure TfrmSobre.LinkLabel1Click(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle,
               'open',
               'https://github.com/rocha33/',
               nil,
               nil,
               SW_SHOWMAXIMIZED);
end;

procedure TfrmSobre.LinkLabel2Click(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle,
               'open',
               'https://www.linkedin.com/in/valdecir-antonio-rocha-desenvolvimento/',
               nil,
               nil,
               SW_SHOWMAXIMIZED);
end;

end.
