unit frmfishermanhome_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, jpeg, ExtCtrls, StdCtrls, GIFImg, shellapi;

type
  Tfrmfishermanhome = class(TForm)
    pnlfmhomebckgd: TPanel;
    imgfmhomebckgd: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnllinks: TPanel;
    pnllinktide: TPanel;
    pnllinkweather: TPanel;
    lbltidelink1: TLabel;
    lbltidelink2: TLabel;
    Label4: TLabel;
    lbllinktide: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbllinkweather: TLabel;
    imgtide: TImage;
    imgweather: TImage;
    lblfmhomewelc: TLabel;
    pnlcatching: TPanel;
    imgfmhomegif: TImage;
    pnlnavi: TPanel;
    pnlbeaches: TPanel;
    lblbeachnavi1: TLabel;
    lblbeachnavi2: TLabel;
    lblbeachnavi3: TLabel;
    pnlbeachnavi: TPanel;
    sbtnbeach: TSpeedButton;
    pnlfishes: TPanel;
    lblfishnavi1: TLabel;
    lblfishnavi2: TLabel;
    lblfishnavi3: TLabel;
    pnlfishnavi: TPanel;
    sbtnfish: TSpeedButton;
    lblfishnavi4: TLabel;
    pnllogo: TPanel;
    imglogo: TImage;
    procedure sbtnbackClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbllinktideClick(Sender: TObject);
    procedure lbllinkweatherClick(Sender: TObject);
    procedure sbtnfishClick(Sender: TObject);
    procedure sbtnbeachClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ibeachin:integer;
  end;

var
  frmfishermanhome: Tfrmfishermanhome;

implementation
    uses frmlogin_u, frmfishinfo_u, frmbeachinfo_u, frmpolicemanhome_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmfishermanhome.FormActivate(Sender: TObject);
begin
(imgtide.Picture.Graphic as TGIFImage).Animate:=True;
(imgweather.Picture.Graphic as TGIFImage).Animate:=True;    //allows gifs to play
(imgfmhomegif.Picture.Graphic as TGIFImage).Animate:=True;
end;

procedure Tfrmfishermanhome.lbllinktideClick(Sender: TObject);
var
slink5:string;
begin
slink5:='https://www.tide-forecast.com/locations/Durban-South-Africa/tides/latest'; //opens links
 ShellExecute(Application.Handle, PChar('open'), PChar(slink5),nil,nil,SW_SHOW);
end;

procedure Tfrmfishermanhome.lbllinkweatherClick(Sender: TObject);
var
slink4:string;
begin
slink4:='https://weather.com/weather/today/l/-29.75,31.07?par=google';
 ShellExecute(Application.Handle, PChar('open'), PChar(slink4),nil,nil,SW_SHOW);
end;

procedure Tfrmfishermanhome.sbtnbackClick(Sender: TObject);
begin
frmfishermanhome.Hide; //Changes forms
frmlogin.Show;

frmlogin.edtfmusername.Clear;  //initializes components
frmlogin.edtfmpassword.Clear;
frmlogin.edtpmusername.Clear;
frmlogin.edtpmpassword.Clear;
frmlogin.edtanusername.Clear;
frmlogin.edtanpassword.Clear;
frmlogin.lblsecure.Hide;
frmlogin.edtsecure.Hide;
frmlogin.edteusername.Clear;
frmlogin.edtepassword.Clear;
frmlogin.spnage.Value:=1;
frmlogin.edtsecure.Clear;
frmlogin.chktac.Checked:=False;
frmlogin.cmbchoice.Text:=' ';
end;

procedure Tfrmfishermanhome.sbtnbeachClick(Sender: TObject);
begin
frmfishermanhome.Hide;        //changes forms
frmbeachinfo.show;
frmbeachinfo.pnladminuse1.Hide;         //intializes components
frmbeachinfo.pnladminuse2.Hide;
frmbeachinfo.pnlcomment.Hide;
frmbeachinfo.pnldata.show;
frmbeachinfo.sbtncomments.Caption:='View Comments';
ibeachin:=1;
end;

procedure Tfrmfishermanhome.sbtnfishClick(Sender: TObject);
begin
frmpolicemanhome.ifishinfo:=1;
frmfishermanhome.Hide;        //changes forms
frmfishinfo.Show;
frmfishinfo.pnladminuse1.Hide;          //intializes components
frmfishinfo.pnladminuse2.Hide;
frmfishinfo.pnlcomment.Hide;
frmfishinfo.pnlspecies.show;
frmfishinfo.sbtncomments.Caption:='View Comments';
ibeachin:=1;
end;

procedure Tfrmfishermanhome.sbtnhelpClick(Sender: TObject);
begin
frmhelp.show;
frmhelp.pnladminhelp.Hide;        //intializes components
frmhelp.pnlpmhelp.Hide;
frmhelp.pnlfmhelp.Show;
end;

end.
