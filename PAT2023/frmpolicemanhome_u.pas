unit frmpolicemanhome_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GIFImg, Buttons, jpeg, ExtCtrls, StdCtrls, shellapi;

type
  Tfrmpolicemanhome = class(TForm)
    pnlbckgd: TPanel;
    imgbckgd: TImage;
    pnllogo: TPanel;
    imglogo: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlpmhomegif: TPanel;
    imghomegif: TImage;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    lblwelcomepm: TLabel;
    pnloptions: TPanel;
    pnlfishinfo: TPanel;
    lblfishinfo: TLabel;
    lblfishinfo2: TLabel;
    lblfishinfo3: TLabel;
    pnlfishinfogo: TPanel;
    sbtnfishinfo: TSpeedButton;
    pnlfmprofiles: TPanel;
    lblfmprofiles: TLabel;
    lblfmprofiles2: TLabel;
    lblfmprofiles3: TLabel;
    pnlfmprofilesgo: TPanel;
    sbtnfrmprofiles: TSpeedButton;
    pnlcatch: TPanel;
    lblcatch: TLabel;
    lblcatch2: TLabel;
    lblcatch3: TLabel;
    pnlcatchgo: TPanel;
    SpeedButton1: TSpeedButton;
    pnlpmlinks: TPanel;
    pnllink1: TPanel;
    pnllink2: TPanel;
    lbllink1: TLabel;
    lbllink1go: TLabel;
    lbllink2go: TLabel;
    lbllink2: TLabel;
    imglink1: TImage;
    imglink2: TImage;
    procedure FormActivate(Sender: TObject);
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnfishinfoClick(Sender: TObject);
    procedure sbtnfrmprofilesClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lbllink1goClick(Sender: TObject);
    procedure lbllink2goClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    ifishinfo:integer;
    ifmpro:integer;
    icatches:integer;
  end;

var
  frmpolicemanhome: Tfrmpolicemanhome;

implementation
    uses frmlogin_u, frmfishinfo_u, frmfishermanprofiles_u, frmcatches_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmpolicemanhome.FormActivate(Sender: TObject);
begin
(imghomegif.Picture.Graphic as TGIFImage).Animate:=True;   //allows for gif to play
(imglink1.Picture.Graphic as TGIFImage).Animate:=True;
(imglink2.Picture.Graphic as TGIFImage).Animate:=True;
end;

procedure Tfrmpolicemanhome.lbllink1goClick(Sender: TObject);
var
slink6:string;
begin
slink6:='https://lawfulliving.co.za/book/text/fisheries--marine-resources.html';//opens link
 ShellExecute(Application.Handle, PChar('open'), PChar(slink6),nil,nil,SW_SHOW);
end;

procedure Tfrmpolicemanhome.lbllink2goClick(Sender: TObject);
var
slink7:string;
begin
slink7:='https://www.swedishclub.com/news/member-alert/no-fishing-without-permit-in-south-african-waters#:~:text=The%20fine%20is%20up%20to,to%20protect%20our%20marine%20resources.';
 ShellExecute(Application.Handle, PChar('open'), PChar(slink7),nil,nil,SW_SHOW);  //opens link
end;

procedure Tfrmpolicemanhome.sbtnbackClick(Sender: TObject);
begin
frmlogin.lbllogin.Caption:='Sign In Here';   //initializes components and switches forms
frmlogin.sbtnchange.Caption:='Create Account Instead?';
frmlogin.lbllogin.Left:=250;
frmlogin.pnllogingin.Show;
frmlogin.pnlsigningup.hide;

frmlogin.edtfmusername.Clear;
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
frmpolicemanhome.Hide;
 frmlogin.Show;

end;

procedure Tfrmpolicemanhome.sbtnfishinfoClick(Sender: TObject);
begin
  ifishinfo:=2;
  frmpolicemanhome.Hide;
  frmfishinfo.Show;
  frmfishinfo.pnladminuse1.Hide;
  frmfishinfo.pnladminuse2.Hide;
  frmfishinfo.pnlcomment.hide;
  frmfishinfo.pnlspecies.show;
  frmfishinfo.sbtncomments.Caption:='View Comments'
end;

procedure Tfrmpolicemanhome.sbtnfrmprofilesClick(Sender: TObject);
begin
frmpolicemanhome.Hide;
frmfishermanprofiles.Show;
ifmpro:=1;
end;

procedure Tfrmpolicemanhome.sbtnhelpClick(Sender: TObject);
begin
frmhelp.show;
frmhelp.pnlfmhelp.Hide;
frmhelp.pnladminhelp.Hide;
frmhelp.pnlpmhelp.Show;

end;

procedure Tfrmpolicemanhome.SpeedButton1Click(Sender: TObject);
begin
frmpolicemanhome.Hide;
frmcatches.show;
frmcatches.pnlstatistics.Hide;
frmcatches.pnldata.Show;
frmcatches.pnlstats.Hide;
icatches:=1;
end;

end.
