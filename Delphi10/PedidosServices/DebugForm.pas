unit DebugForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, PedidosServices;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FStarted: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FStarted := False;
  btnStart.Enabled := True;
  btnStop.Enabled := False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FStarted then
    Pedidos.ServiceStop(nil, FStarted);
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  Pedidos.ServiceStart(nil, FStarted);
  btnStart.Enabled := not FStarted;
  btnStop.Enabled := FStarted;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  Pedidos.ServiceStop(nil, FStarted);
  btnStart.Enabled := not FStarted;
  btnStop.Enabled := FStarted;
end;

end.
