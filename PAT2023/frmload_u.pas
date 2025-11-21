unit frmload_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, jpeg;

type
  Tfrmload = class(TForm)
    pnllogo: TPanel;
    imglogo: TImage;
    prbloading: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmload: Tfrmload;

implementation
     uses pat23_u;
{$R *.dfm}

procedure Tfrmload.Timer1Timer(Sender: TObject);
begin
prbloading.StepIt;   //starts loadbar
if prbloading.Position=prbloading.max then   //occurs when progres bar is complete
begin
  Timer1.Destroy;
  prbloading.Visible:=False;
  frmload.Hide;    //change forms when loadbar is compleated
  frmwelcome.Show;

end;

end;

end.
