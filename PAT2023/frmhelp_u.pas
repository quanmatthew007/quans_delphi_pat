unit frmhelp_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ComCtrls, Buttons, ShellApi;

type
  Tfrmhelp = class(TForm)
    pnlbackground: TPanel;
    pnllogo: TPanel;
    imglogo: TImage;
    imgbackground: TImage;
    pclhelp: TPageControl;
    tbsadmin: TTabSheet;
    tbspoliceman: TTabSheet;
    tbsfisherman: TTabSheet;
    pnladminhelp: TPanel;
    pnlpmhelp: TPanel;
    pnlfmhelp: TPanel;
    redadminhelp: TRichEdit;
    redpmhelp: TRichEdit;
    redfmhelp: TRichEdit;
    lbltitle: TLabel;
    tbsLoginhomehelp: TTabSheet;
    pnlloginhelp: TPanel;
    redloginhelp: TRichEdit;
    pnlinsta: TPanel;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmhelp: Tfrmhelp;

implementation

{$R *.dfm}

procedure Tfrmhelp.FormCreate(Sender: TObject);
var
tfile:textfile;
sline:string;
begin
redadminhelp.Lines.clear;//initializes the rich edit
 if fileexists('adminhelp.txt') then  //checks if file exists
begin
assignfile(tfile,'adminhelp.txt');//makes a copy of file in delphi
reset(tfile);             // brings cursor to the top
while not eof(tfile) do
begin
  readln(tfile,sline);  //copies the line
  redadminhelp.Lines.Add(sline);  //outputs the line
end;//while
closefile(tfile);
end;//if
 /////////////////////////////////////////
   redpmhelp.Lines.clear;//initializes the rich edit
 if fileexists('policemenhelp.txt') then  //checks if file exists
begin
assignfile(tfile,'policemenhelp.txt');//makes a copy of file in delphi
reset(tfile);             // brings cursor to the top
while not eof(tfile) do
begin
  readln(tfile,sline);  //copies the line
  redpmhelp.Lines.Add(sline);  //outputs the line
end;//while
closefile(tfile);
end;//if
 //////////////////////////////////////////////////
redfmhelp.Lines.clear;//initializes the rich edit
 if fileexists('fishermenhelp.txt') then  //checks if file exists
begin
assignfile(tfile,'fishermenhelp.txt');//makes a copy of file in delphi
reset(tfile);             // brings cursor to the top
while not eof(tfile) do
begin
  readln(tfile,sline);  //copies the line
  redfmhelp.Lines.Add(sline);  //outputs the line
end;//while
closefile(tfile);
end;//if
////////////////////////////////////////////////////////
redloginhelp.Lines.clear;//initializes the rich edit
 if fileexists('loginhelp.txt') then  //checks if file exists
begin
assignfile(tfile,'loginhelp.txt');//makes a copy of file in delphi
reset(tfile);             // brings cursor to the top
while not eof(tfile) do
begin
  readln(tfile,sline);  //copies the line
  redloginhelp.Lines.Add(sline);  //outputs the line
end;//while
closefile(tfile);
end;//if

end;

procedure Tfrmhelp.Image1Click(Sender: TObject);
var
sLink1:string;
begin
 slink1:='https://www.instagram.com/findr_fish/';
 ShellExecute(Application.Handle, PChar('open'), PChar(slink1),nil,nil,SW_SHOW);//executes link1
end;


end.
