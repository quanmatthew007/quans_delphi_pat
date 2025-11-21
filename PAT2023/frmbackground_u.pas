unit frmbackground_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons, ComCtrls, comobj, MPlayer;

type
  Tfrmbackground = class(TForm)
    pnlbckgd: TPanel;
    imgbckgd: TImage;
    pnllogo: TPanel;
    imglogo: TImage;
    pnlexit: TPanel;
    sbtnexit: TSpeedButton;
    rgptac: TRadioGroup;
    pnlreadtac: TPanel;
    sbtnreadtac: TSpeedButton;
    MediaPlayer1: TMediaPlayer;
    redoutput: TRichEdit;

    procedure Button1Click(Sender: TObject);
    procedure sbtnexitClick(Sender: TObject);
    procedure rgptacClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtstartappClick(Sender: TObject);
    procedure sbtnreadtacClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    bfound:boolean;
    procedure createdynamic; //creates dynamic componenets
  end;

var
  frmbackground: Tfrmbackground;
   pnlstartapp: TPanel; //dynamic comp
   sbtnstartapp: TSpeedButton;//dynamic comp

implementation
       uses frmload_u, pat23_u;
{$R *.dfm}

procedure Tfrmbackground.Button1Click(Sender: TObject);
begin
application.Terminate; //stops program
end;

procedure Tfrmbackground.createdynamic;
begin
/////////////////
//creating dynamic panel
 pnlstartapp:=Tpanel.Create(frmbackground); //creates dynamic componenets
 pnlstartapp.Parent:=pnlbckgd;
 pnlstartapp.top:=528;        //allocates properties to dynamic componenet
 pnlstartapp.Left:=515;
 pnlstartapp.Height:=73;
 pnlstartapp.Width:=257;
 pnlstartapp.Caption:='';
 pnlstartapp.ParentBackground:=False;
 pnlstartapp.ParentColor:=False;
 pnlstartapp.Color:=clBlue;

 //creating dynamic speed button
 sbtnstartapp:=TSpeedButton.Create(frmbackground); //creates dynamic componenets
 sbtnstartapp.Parent:=pnlstartapp;
 sbtnstartapp.Top:=0;            //allocates properties to dynamic componenet
 sbtnstartapp.Left:=0;
 sbtnstartapp.Height:=73;
 sbtnstartapp.Width:=257;
 sbtnstartapp.Caption:='Start Program';
 sbtnstartapp.ParentFont:=False;
 sbtnstartapp.Font.Name:='Harlow Solid Italic';
 sbtnstartapp.Font.Color:=clWhite;
 sbtnstartapp.Font.Size:=22;
 sbtnstartapp.Flat:=True;
 sbtnstartapp.OnClick:=sbtstartappClick;
 sbtnstartapp.Hint:='Click Here To Begin And Continue Inside Program';
 sbtnstartapp.ShowHint:=True;
end;

procedure Tfrmbackground.FormCreate(Sender: TObject);
var
tfile:textfile;
sline:string;
begin
bfound:=True;

if fileexists('tac23.txt') then   //checks if file is in folder
 begin
 assignfile(tfile,'tac23.txt'); //creates a copy of file in delphi folder
 reset(tfile);  //brings cursor to top
 while not Eof(tfile) do
   begin
     readln(tfile,sline);//puts a single line into sline from tfile
     redoutput.Lines.Add(sline);//displays the line
   end; //while loop
     closefile(tfile); //closes tfile when finished
 end
 else
 begin
   showmessage('The file does not exist'); //displays if file is not in folder
 end;
end;

procedure Tfrmbackground.FormShow(Sender: TObject);
begin
MediaPlayer1.FileName:='lanareyvideogamesinstrum.wav';//plays specific song from folder
MediaPlayer1.Open;//opens the songs file
MediaPlayer1.Play;//Plays the specific song
end;

procedure Tfrmbackground.rgptacClick(Sender: TObject);
begin
if rgptac.ItemIndex=0 then //creates dynamic components only if agree is chosen
begin
//////////////
 createdynamic;//creates dynamic components
 bfound:=False;
end
else
begin
 showmessage('Please Agree To The Terms And Conditions To Continue');
 if bfound=False then //executes if disagree is chosen
 begin

  pnlstartapp.Visible:=False; //hides dynamic components if disagree is chosen
  bfound:=True; //enables panel to be shown if agree is chosen after
 end;

end;
end;

procedure Tfrmbackground.sbtnexitClick(Sender: TObject);
begin
application.Terminate;//stops program running

end;


procedure Tfrmbackground.sbtnreadtacClick(Sender: TObject); //reads contents of terms and conditions rich edit
Var
  Voice: OleVariant;
begin
mediaplayer1.Pause;     //stops background music
 Voice:=createOleObject('SAPI.spVoice');
 Voice.Speak(redoutput.Text); //reads contents redtac outloud

MediaPlayer1.Resume;//resumes background music

end;

procedure Tfrmbackground.sbtstartappClick(Sender: TObject);  //executes when dynamic speed button is clicked
begin
//shows loadform if they choose to start the program
frmload.Show;
//hides compoinents so they cant be seen in background
redoutput.Hide;
rgptac.Hide;
pnlstartapp.Hide;
pnlreadtac.Hide;
end;

//reference storage to follow

end.
