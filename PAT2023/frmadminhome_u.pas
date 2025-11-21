unit frmadminhome_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GIFImg, Buttons, StdCtrls, jpeg, ExtCtrls;

type
  Tfrmadminhome = class(TForm)
    pnlbckgdan: TPanel;
    imgbckgdan: TImage;
    pnllogo: TPanel;
    imglogo: TImage;
    lblanwelcome: TLabel;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    imgadmin: TImage;
    lblfmprofiles: TLabel;
    lblfmprofiles2: TLabel;
    lblfmprofiles3: TLabel;
    pnlfmprofilesgo: TPanel;
    sbtnfrmprofiles: TSpeedButton;
    pnlpmprofiles: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlpmprofilesgo: TPanel;
    sbtnpmprofiles: TSpeedButton;
    lblfishinfo: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    sbtnfishgo: TSpeedButton;
    sbtncatchesgo: TSpeedButton;
    sbtnbeachgo: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure sbtnfrmprofilesClick(Sender: TObject);
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnbeachgoClick(Sender: TObject);
    procedure sbtncatchesgoClick(Sender: TObject);
    procedure sbtnfishgoClick(Sender: TObject);
    procedure sbtnpmprofilesClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure goback;
  end;

var
  frmadminhome: Tfrmadminhome;

implementation
     uses frmlogin_u, frmfishermanprofiles_u, frmpolicemanhome_u, frmfishermanhome_u,
      frmbeachinfo_u, frmcatches_u, frmfishinfo_u, frmpolicemanprofiles_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmadminhome.FormActivate(Sender: TObject);
begin
(imgadmin.Picture.Graphic as TGIFImage).Animate:=True;//allows for gif to animate
end;

procedure Tfrmadminhome.goback;
begin
frmlogin.lbllogin.Caption:='Sign In Here';  //initializes components
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

frmadminhome.Hide; //changes forms
frmlogin.Show;
end;

procedure Tfrmadminhome.sbtnbackClick(Sender: TObject);
begin
goback;

end;

procedure Tfrmadminhome.sbtnbeachgoClick(Sender: TObject);
begin
frmfishermanhome.ibeachin:=2;
frmadminhome.Hide; //changes forms
frmbeachinfo.show;
frmbeachinfo.pnladminuse1.Show;
frmbeachinfo.pnladminuse2.Show;
frmbeachinfo.pnlcomment.hide;
frmbeachinfo.pnldata.show;
frmbeachinfo.sbtncomments.Caption:='View Comments';

end;

procedure Tfrmadminhome.sbtncatchesgoClick(Sender: TObject);
begin
frmadminhome.Hide; //changes forms
frmcatches.show;
frmcatches.pnlstatistics.Hide;
frmCatches.pnlstats.Show;
frmcatches.pnldata.Show;
frmcatches.sbtnstats.Caption:='View Stats';
frmpolicemanhome.icatches:=2;
end;

procedure Tfrmadminhome.sbtnfishgoClick(Sender: TObject);
begin
frmpolicemanhome.ifishinfo:=3;
frmadminhome.Hide;            //changes forms
frmfishinfo.show;
frmfishinfo.pnladminuse1.Show;
frmfishinfo.pnladminuse2.Show;
frmfishinfo.pnlcomment.hide;
frmfishinfo.pnlspecies.show;
frmfishinfo.sbtncomments.Caption:='View Comments'
end;

procedure Tfrmadminhome.sbtnfrmprofilesClick(Sender: TObject);
begin
frmadminhome.Hide;            //changes forms
frmfishermanprofiles.Show;
frmpolicemanhome.ifmpro:=2;
end;

procedure Tfrmadminhome.sbtnhelpClick(Sender: TObject);
begin
 frmhelp.Show;                  //changes forms
 frmhelp.tbspoliceman.Hide;
 frmhelp.pnlpmhelp.Hide;
 frmhelp.tbsfisherman.Hide;
 frmhelp.pnlfmhelp.Hide;
 frmhelp.pnladminhelp.Show;
end;

procedure Tfrmadminhome.sbtnpmprofilesClick(Sender: TObject);
begin
frmadminhome.Hide;               //changes forms
frmpolicemanprofiles.show;
frmpolicemanprofiles.pnlduties.Hide;
frmpolicemanprofiles.pnldata.Show;
frmpolicemanprofiles.sbtnduties.Caption:='View Duties';
end;

end.
