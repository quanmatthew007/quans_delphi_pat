unit pat23_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons, StdCtrls, ShellApi;

type
  Tfrmwelcome = class(TForm)
    pnlwelcome: TPanel;
    imgbckgd: TImage;
    pnllogo: TPanel;
    imglogo: TImage;
    lblwelcome: TLabel;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnllinks: TPanel;
    pnllink1: TPanel;
    pnllink3: TPanel;
    pnllink2: TPanel;
    pnlsignin: TPanel;
    pnllogin: TPanel;
    pnlsignup: TPanel;
    pnlsignins: TPanel;
    sbtnsignin: TSpeedButton;
    pnlsignups: TPanel;
    sbtnsignup: TSpeedButton;
    lblsignin: TLabel;
    lblsignin2: TLabel;
    lblsignin3: TLabel;
    lblsignup: TLabel;
    lblsignup2: TLabel;
    lblsignup3: TLabel;
    lbllink11: TLabel;
    lbllink12: TLabel;
    lbllink13: TLabel;
    lbllink21: TLabel;
    lbllink22: TLabel;
    lbllink23: TLabel;
    lbllink31: TLabel;
    lbllink32: TLabel;
    lbllink33: TLabel;
    lbllink34: TLabel;
    pnlabout: TPanel;
    lblabout: TLabel;
    pnlabimg1: TPanel;
    pnlabimg2: TPanel;
    pnlabimg3: TPanel;
    imgabout1: TImage;
    imgabout2: TImage;
    imgabout3: TImage;
    lblinfo1: TLabel;
    lblinfo2: TLabel;
    lblinfo3: TLabel;
    lblinfo4: TLabel;
    lblinfo5: TLabel;
    procedure sbtnsigninClick(Sender: TObject);
    procedure sbtnsignupClick(Sender: TObject);
    procedure lbllink13Click(Sender: TObject);
    procedure lbllink23Click(Sender: TObject);
    procedure lbllink34Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    bfound:boolean;
    procedure signup;  //allows user to acess login page, signup panel
    procedure signin; //allows user to acess login page, signin panel
  end;

var
  frmwelcome: Tfrmwelcome;

implementation
   uses frmlogin_u,frmbackground_u, frmhelp_u;
{$R *.dfm}


procedure Tfrmwelcome.FormShow(Sender: TObject);
begin
frmbackground.MediaPlayer1.Stop;//stops background music
end;

procedure Tfrmwelcome.lbllink13Click(Sender: TObject);
var
sLink1:string;
begin
 slink1:='https://fishingbooker.com/blog/fishing-in-durban/';  //gives link 1 a web adress
 ShellExecute(Application.Handle, PChar('open'), PChar(slink1),nil,nil,SW_SHOW);//executes link1
end;

procedure Tfrmwelcome.lbllink23Click(Sender: TObject);
var
slink2:string;
begin
 slink2:='https://greentumble.com/sustainable-fishing-practices'; //gives link 2 a web adress
 ShellExecute(Application.Handle, PChar('open'), PChar(slink2),nil,nil,SW_SHOW); //executes link2
end;

procedure Tfrmwelcome.lbllink34Click(Sender: TObject);
var
slink3:string;
begin
 slink3:='https://theoceancleanup.com/donate/';   //gives link 3 a web adress
 ShellExecute(Application.Handle, PChar('open'), PChar(slink3),nil,nil,SW_SHOW); //executes link3
end;

procedure Tfrmwelcome.sbtnhelpClick(Sender: TObject); //shows help page
begin
frmhelp.show;
frmhelp.pnladminhelp.Hide;
frmhelp.pnlpmhelp.hide;
frmhelp.pnlfmhelp.Hide;
end;

procedure Tfrmwelcome.sbtnsigninClick(Sender: TObject);
begin
signin; //executes procedure signin
end;

procedure Tfrmwelcome.sbtnsignupClick(Sender: TObject);
begin
signup; //executes procedure signup
end;

procedure Tfrmwelcome.signin;
begin
frmlogin.lbllogin.Caption:='Sign In Here';    //initializes components
frmlogin.sbtnchange.Caption:='Create Account Instead?';
frmlogin.lbllogin.Left:=320;
frmlogin.pnllogingin.Show;
frmlogin.pnlsigningup.hide;
frmwelcome.Hide;  //changes forms
frmlogin.Show;
frmlogin.chktac.Checked:=False; //initiallizes the login panels components
end;

procedure Tfrmwelcome.signup;
begin
  frmlogin.lbllogin.Caption:='Create An Account Here';   //initializes components
frmlogin.sbtnchange.Caption:='Sign In Instead?';
 frmlogin.lbllogin.Left:=250;
frmlogin.pnllogingin.Hide;
frmlogin.pnlsigningup.Show;
frmwelcome.Hide;  //changes forms
frmlogin.Show;
frmlogin.chktac.Checked:=False; //initializes  the signup panels componenets
end;

end.
