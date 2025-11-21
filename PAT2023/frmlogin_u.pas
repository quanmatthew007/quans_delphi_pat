unit frmlogin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons, Spin, ComCtrls, clsfmlogin, clspmlogin,
  comobj;

type
  Tfrmlogin = class(TForm)
    pnlbackground: TPanel;
    imgbckgd: TImage;
    pnllogo: TPanel;
    imglogo: TImage;
    lbllogin: TLabel;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlchange: TPanel;
    sbtnchange: TSpeedButton;
    pnllogingin: TPanel;
    pnlfisherman: TPanel;
    pnlpoliceman: TPanel;
    pnladmin: TPanel;
    lbllogingin: TLabel;
    cmblogin: TComboBox;
    lblfisherman: TLabel;
    lblfmusername: TLabel;
    edtfmusername: TEdit;
    lblfmpassword: TLabel;
    edtfmpassword: TEdit;
    pnlfmlogin: TPanel;
    sbtnfmlogin: TSpeedButton;
    lblpoliceman: TLabel;
    lblpmusername: TLabel;
    lblpmpassword: TLabel;
    edtpmusername: TEdit;
    edtpmpassword: TEdit;
    pnlpmlogin: TPanel;
    sbtnpmlogin: TSpeedButton;
    pnldisguise: TPanel;
    pnldisguise2: TPanel;
    sbtndisguise: TSpeedButton;
    lbladmin: TLabel;
    lblanusername: TLabel;
    lblanpassword: TLabel;
    edtanusername: TEdit;
    edtanpassword: TEdit;
    pnlanlogin: TPanel;
    sbtnanlogin: TSpeedButton;
    pnlsigningup: TPanel;
    lblsigningup: TLabel;
    lblchoice: TLabel;
    lbleusername: TLabel;
    lblepassword: TLabel;
    lbleage: TLabel;
    cmbchoice: TComboBox;
    edteusername: TEdit;
    spnage: TSpinEdit;
    edtepassword: TEdit;
    pnlesignup: TPanel;
    sbtnsignup: TSpeedButton;
    chktac: TCheckBox;
    lbltac: TLabel;
    pnltac: TPanel;
    redtac: TRichEdit;
    pnlreadtac: TPanel;
    sbtnreadtac: TSpeedButton;
    lblsecure: TLabel;
    edtsecure: TEdit;
    pnlcontinuity1: TPanel;
    pnlcontinuity2: TPanel;
    pnlhide1: TPanel;
    imgpwordfm: TImage;
    sbtnhide1: TSpeedButton;
    pnlhide2: TPanel;
    imgpwordpm: TImage;
    sbtnhide2: TSpeedButton;
    pnlhide3: TPanel;
    imgpwordan: TImage;
    sbtnhide3: TSpeedButton;
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnchangeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtnloginconfirmClick(Sender: TObject);
    procedure sbtndisguiseClick(Sender: TObject);
    procedure sbtnsignupClick(Sender: TObject);
    procedure cmbchoiceChange(Sender: TObject);
    procedure sbtnfmloginClick(Sender: TObject);
    procedure sbtnpmloginClick(Sender: TObject);
    procedure sbtnanloginClick(Sender: TObject);
    procedure cmbloginChange(Sender: TObject);
    procedure sbtnhide1Click(Sender: TObject);
    procedure sbtnhide2Click(Sender: TObject);
    procedure sbtnhide3Click(Sender: TObject);
    procedure sbtnreadtacClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure edtfmusernameClick(Sender: TObject);
    procedure edtfmpasswordClick(Sender: TObject);
    procedure edtpmusernameClick(Sender: TObject);
    procedure edtpmpasswordClick(Sender: TObject);
    procedure edtanusernameClick(Sender: TObject);
    procedure edtanpasswordClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bchange:boolean;
    spubuname:string;
    sstatus:string;
    procedure signingup; //executes when signing up
    procedure fmlogpnl;   //executes when policeman is chosen as a title
    procedure pmlogpnl;   //executes when fisherman is chosen as a title
    procedure anlogin;     //executes when an attemp to login as admin

  end;

var
  frmlogin: Tfrmlogin;
  bpass1:Boolean; //boolean variables for hide password
  bpass2:boolean;
  bpass3:boolean;

  objfmlogin:tfmlogin; //Object classes for loging-in
  objpmlogin:tpmlogin;
implementation
      uses pat23_u, frmfishermanhome_u, frmpolicemanhome_u, frmadminhome_u, frmhelp_u;

{$R *.dfm}

procedure Tfrmlogin.anlogin;
var
suname,spword:string;
begin
suname:=edtanusername.Text; //extracts variables from components
spword:=edtanpassword.Text;
if (suname='Findradmin')AND (spword='F1I2N3D4R5#') then  //validates entered details
begin
  Showmessage('Login Successful, Welcome Admin!');
  frmlogin.Hide;  //changes forms
  frmadminhome.Show;
  spubuname:=suname;
  sstatus:='Administrator';
end
else
begin  //executes if login details are incorrect
  edtanusername.Color:=clRed;
  edtanpassword.Color:=clRed;
  Showmessage('Incorrect details, please review your login details'); //if details are wrong , lets user know
end;
end;

procedure Tfrmlogin.cmbchoiceChange(Sender: TObject);
begin
if cmbchoice.Text='Policeman' then    //shows and initializes the signup panels components
begin
 lblsecure.Show;
 edtsecure.Show;
 edteusername.Clear;
 edtepassword.Clear;
 spnage.Value:=1;
 chktac.Checked:=False;
end
else
if cmbchoice.Text='Fisherman' then //shows and initializes the signup panels components
begin
  lblsecure.Hide;
  edtsecure.Hide;
  edteusername.Clear;
  edtepassword.Clear;
  spnage.Value:=1;
  edtsecure.Clear;
  chktac.Checked:=False;
end;
end;

procedure Tfrmlogin.cmbloginChange(Sender: TObject);
var
stitle:string;
begin
stitle:=cmblogin.Text;

if stitle='Fisherman' then  //shows and initializes the fisherman login panel
begin

  fmlogpnl;
end
else
if stitle='Policeman' then //shows and initializes the policeman login panel
 begin

  pmlogpnl;
 end
 else
 begin
   showmessage('Please select a title');
 end;


end;

procedure Tfrmlogin.edtanpasswordClick(Sender: TObject);
begin
   edtanusername.Color:=clNavy;    //Initializes components
   edtanpassword.Color:=clNavy;
end;

procedure Tfrmlogin.edtanusernameClick(Sender: TObject);
begin
edtanusername.Color:=clNavy;   //Initializes components
edtanpassword.Color:=clNavy;
end;

procedure Tfrmlogin.edtfmpasswordClick(Sender: TObject);
begin
edtfmusername.Color:=clNavy;   //Initializes components
edtfmpassword.Color:=clNavy;
end;

procedure Tfrmlogin.edtfmusernameClick(Sender: TObject);
begin
edtfmusername.Color:=clNavy; //Initializes components
edtfmpassword.Color:=clNavy;
end;

procedure Tfrmlogin.edtpmpasswordClick(Sender: TObject);
begin
     edtpmusername.Color:=clNavy;   //Initializes components
     edtpmpassword.Color:=clNavy;
end;

procedure Tfrmlogin.edtpmusernameClick(Sender: TObject);
begin
edtpmusername.Color:=clNavy;   //Initializes components
edtpmpassword.Color:=clNavy;
end;

procedure Tfrmlogin.fmlogpnl;
begin
  pnladmin.Hide;
  pnlpoliceman.Hide;     //switche
  pnlfisherman.Show;
  edtfmusername.Clear;       //Initializes components
  edtfmusername.SetFocus;
  edtfmpassword.Clear;
  edtpmusername.Clear;
  edtpmpassword.Clear;
  edtanusername.Clear;
  edtanpassword.Clear;

end;

procedure Tfrmlogin.FormCreate(Sender: TObject);
var
tfile:textfile;
sline:string;
begin
bpass1:=False; //initializes the show password components
bpass2:=false;
bpass3:=false;
imgpwordfm.Picture.LoadFromFile('passhide.jpg'); //initializes the show password components
imgpwordpm.Picture.LoadFromFile('passhide.jpg');
imgpwordan.Picture.LoadFromFile('passhide.jpg');

pnlfisherman.Hide;  //initializes the login components
pnladmin.Hide;
pnlpoliceman.Hide;
lblsecure.Hide;
edtsecure.Hide;

if fileexists('tac23.txt') then//reads terms and cconditions into signup richedit
 begin
 assignfile(tfile,'tac23.txt');
 reset(tfile);  //brings cursor to top
 while not Eof(tfile) do
   begin
     readln(tfile,sline);//puts a single line into sline from tfile
     redtac.Lines.Add(sline);//displays the line
   end; //while loop
     closefile(tfile);
 end
 else
 begin
   showmessage('The file does not exist');
 end;
end;

procedure Tfrmlogin.pmlogpnl;//executes when policeman is chosen as login title
begin
  pnladmin.Hide;     //initializes login panels components
  pnlpoliceman.show;
  pnlfisherman.hide;
  edtfmusername.Clear;
  edtfmpassword.Clear;
  edtpmusername.Clear;
  edtpmusername.SetFocus;
  edtpmpassword.Clear;
  edtanusername.Clear;
  edtanpassword.Clear;
end;

procedure Tfrmlogin.sbtnanloginClick(Sender: TObject);
begin
anlogin;
end;

procedure Tfrmlogin.sbtnbackClick(Sender: TObject);
begin
frmlogin.Hide;   //takes user to home form
frmwelcome.Show;
pnladmin.Hide;
pnlfisherman.Hide;//initializes the components for next use
pnlpoliceman.Hide;
edtfmusername.Clear;
edtfmpassword.Clear;
edtpmusername.Clear;
edtpmpassword.Clear;
edtanusername.Clear;
edtanpassword.Clear;
lblsecure.Hide;
edtsecure.Hide;
edteusername.Clear;
edtepassword.Clear;
spnage.Value:=1;
edtsecure.Clear;
chktac.Checked:=False;
cmbchoice.Text:=' ';
end;

procedure Tfrmlogin.sbtnchangeClick(Sender: TObject);
begin
if sbtnchange.Caption='Create Account Instead?' then //switches between login and signup panel
begin
  sbtnchange.Caption:='Sign In Instead?';
  lbllogin.caption:='Create An Account Here';
  lbllogin.Left:=250;
  pnllogingin.hide;
  pnlsigningup.Show;
  cmbchoice.text:='';
  edteusername.Clear;
  edtepassword.Clear;
  spnage.Value:=1;
  lblsecure.Hide;
  edtsecure.Hide;
  chktac.Checked:=False;
end
else
 if sbtnchange.Caption='Sign In Instead?' then //switches between login and signup panel
begin
  sbtnchange.Caption:='Create Account Instead?';
  lbllogin.caption:='Sign In Here';
  lbllogin.Left:=320;
  cmblogin.Text:='Choose Appropriate Title';
  pnlsigningup.Hide;
  pnllogingin.Show;
  pnlfisherman.Hide;
  pnlpoliceman.Hide;
  pnladmin.Hide;

end;

end;

procedure Tfrmlogin.sbtndisguiseClick(Sender: TObject);
var
spassword:string;
begin
spassword:=Inputbox('','Enter Password To Unlock',''); //unlocks the admin login panel
if spassword='####' then
begin
  pnladmin.Show;
  pnlfisherman.Hide;
  pnlpoliceman.Hide;
  edtfmusername.Clear;
  edtfmpassword.Clear;
  edtpmusername.Clear;
  edtpmpassword.Clear;
  cmblogin.Text:='Choose Appropriate Title';
  edtanusername.SetFocus;
end
else
begin
  showmessage('Nice Try But Incorrect!')
end;
end;

procedure Tfrmlogin.sbtnfmloginClick(Sender: TObject);
var
sfmuname,sfmpword:String;

begin
sfmuname:=edtfmusername.Text;
sfmpword:=edtfmpassword.Text;

objfmlogin:=tfmlogin.Create(sfmuname,sfmpword);

objfmlogin.setvalid;

showmessage(objfmlogin.tostring);

objfmlogin.move;

spubuname:=sfmuname;
sstatus:='Fisherman';

end;

procedure Tfrmlogin.sbtnloginconfirmClick(Sender: TObject);
var
stitle:string;
begin
stitle:=cmblogin.Text;

if stitle='Fisherman' then
begin
  pnladmin.Hide;
  pnlpoliceman.Hide;
  pnlfisherman.Show;
  edtfmusername.Clear;
  edtfmusername.SetFocus;
  edtfmpassword.Clear;
  edtpmusername.Clear;
  edtpmpassword.Clear;
  edtanusername.Clear;
  edtanpassword.Clear;
end
else
if stitle='Policeman' then
 begin
  pnladmin.Hide;
  pnlpoliceman.show;
  pnlfisherman.hide;
  edtfmusername.Clear;
  edtfmpassword.Clear;
  edtpmusername.Clear;
  edtpmusername.SetFocus;
  edtpmpassword.Clear;
  edtanusername.Clear;
  edtanpassword.Clear;
 end
 else
 begin
   showmessage('Please select a title');
 end;


end;

procedure Tfrmlogin.sbtnpmloginClick(Sender: TObject);
var
spmuname,spmpword:String;

begin
spmuname:=edtpmusername.Text;
spmpword:=edtpmpassword.Text;

objpmlogin:=tpmlogin.Create(spmuname,spmpword);

objpmlogin.setvalid;

showmessage(objpmlogin.tostring);

objpmlogin.move;
 spubuname:=spmuname;
 sstatus:='Policeman';
end;

procedure Tfrmlogin.sbtnreadtacClick(Sender: TObject);
Var
  Voice: OleVariant;
begin

 Voice:=createOleObject('SAPI.spVoice');
 Voice.Speak(redtac.Text); //reads contents redtac outloud
end;

procedure Tfrmlogin.sbtnsignupClick(Sender: TObject);
begin
  signingup;
end;



procedure Tfrmlogin.signingup;
var
ilengthuname,ilengthpword,I,inum,ispecial:integer;
bfound:boolean;
susername,spassword,sline:string;
tfilefm, tfilepm:textfile;
begin
susername:=edteusername.Text;
ilengthuname:=length(susername);
spassword:=edtepassword.Text;
ilengthpword:=length(spassword);
bfound:=False;

 inum:=0;
 ispecial:=0;
if ilengthpword>4 then
begin
 for I := 1 to ilengthpword do
begin
  if spassword[i] in ['0'..'9'] then
  begin
    inc(inum);
  end;
  if spassword[i] in ['@','#','$','%','&','*'] then
  begin
    inc(ispecial);
  end;
end;//for loop
end//if statement
 else
 begin
   showmessage('Password too short');
 end;


 if (inum>0) AND (ispecial>0) then
  begin
    bfound:=True;
  end
  else
  begin
    showmessage('Password invalid, Try Adding Special Characters or Numbers');
  end;

   if bfound=true then
   begin
     if ilengthuname>4 then  //validates username
     begin
      if cmbchoice.Text='Fisherman' then //execute if fisherman is selected as title
      begin
         if spnage.Value>11 then //validates age
         begin
          if chktac.Checked=True then  //checks if t&c's are accepted
          begin
           if fileexists('fishermanlogin.txt') then
           begin
           sline:=susername+'!'+spassword;
           assignfile(tfilefm,'fishermanlogin.txt');
           Append(tfilefm);
           writeln(tfilefm,sline);
           closefile(tfilefm);
           showmessage('Account Created successfully, you are now signed in as a fisherman');
           frmlogin.Hide;
           frmfishermanhome.Show;
           spubuname:=susername;
           sstatus:='Fisherman';
            ///////////////////
           end;//if fileexists, to test if the file is present in the folder
          end //t&c validation
          else
          begin
            showmessage('Please Agree To Terms And Conditions');
          end;//t&c validation

         end
         else
         begin
           Showmessage('Fisherman Too young');
         end;//fm age validation
      end//if fisherman is chosen
      else
      if cmbchoice.Text='Policeman' then
      begin
          if spnage.value>17 then
          begin
           if edtsecure.Text='123#@' then
           begin
             if chktac.Checked=True then
          begin
          if fileexists('policemanlogin.txt') then
           begin
           sline:=susername+'!'+spassword;
           assignfile(tfilepm,'policemanlogin.txt');
           Append(tfilepm); //alows for additions to textfiles
           writeln(tfilepm,sline);
           closefile(tfilepm);
           showmessage('Account Created successfully, you are now signed in as a Policeman');
           frmlogin.Hide;
           frmpolicemanhome.show;
           spubuname:=susername;
           sstatus:='Policeman';
           /////////////////////////////

           end;//if fileexists, to test if the file is present in the folder
           ///////////
          end
          else
          begin
            showmessage('Please Agree To Terms And Conditions');
          end;//tac validation
           end
           else
           begin
             Showmessage('Inappropriate Secure Code');
           end;//pm secuity code

          end
          else
          begin
            showmessage('Invalid Age');
          end;
      end//if policeman is selected
      else
      begin
        showmessage('Please select a title');
      end;
     end//username length>4
     else
     begin
       showmessage('Username Too Short');
     end;//username length>4

   end;

end;

procedure Tfrmlogin.sbtnhelpClick(Sender: TObject);
begin
frmhelp.show;
frmhelp.pnladminhelp.Hide;
frmhelp.pnlpmhelp.hide;
frmhelp.pnlfmhelp.Hide;
end;

procedure Tfrmlogin.sbtnhide1Click(Sender: TObject);
begin
if bpass1=False then
begin
   imgpwordfm.Picture.loadfromfile('passshow.jpg');
   bpass1:=True;
   edtfmpassword.PasswordChar:=#9679;
end
else
if bpass1=True then
begin
 imgpwordfm.Picture.loadfromfile('passhide.jpg');
   bpass1:=False;
   edtfmpassword.PasswordChar:=#0;
end;

end;

procedure Tfrmlogin.sbtnhide2Click(Sender: TObject);
begin
if bpass2=False then
begin
   imgpwordpm.Picture.loadfromfile('passshow.jpg');
   bpass2:=True;
   edtpmpassword.PasswordChar:=#9679;
end
else
if bpass2=True then
begin
 imgpwordpm.Picture.loadfromfile('passhide.jpg');
   bpass2:=False;
   edtpmpassword.PasswordChar:=#0;
end;

end;

procedure Tfrmlogin.sbtnhide3Click(Sender: TObject);
begin
if bpass3=False then
begin
   imgpwordan.Picture.loadfromfile('passshow.jpg');
   bpass3:=True;
   edtanpassword.PasswordChar:=#9679;
end
else
if bpass3=True then
begin
 imgpwordan.Picture.loadfromfile('passhide.jpg');
   bpass3:=False;
   edtanpassword.PasswordChar:=#0;
end;

end;

end.
