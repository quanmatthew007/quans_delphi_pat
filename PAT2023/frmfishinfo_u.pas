unit frmfishinfo_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons, StdCtrls, ComCtrls, Spin, Grids, DBGrids, dmPAT23_u, Validation_U;

type
  Tfrmfishinfo = class(TForm)
    pnlfibckgd: TPanel;
    pnllogo: TPanel;
    imglogo: TImage;
    imgfibckgd: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    lblfishinfotitle: TLabel;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnlspecies: TPanel;
    Dbgfish: TDBGrid;
    pnloutput: TPanel;
    redoutput: TRichEdit;
    lblsearchtitle: TLabel;
    pnlsearching: TPanel;
    sbtnsearching: TSpeedButton;
    edtsearch: TEdit;
    pnlsearch: TPanel;
    lblsearch: TLabel;
    edtspecies: TEdit;
    edtlocation: TEdit;
    cmbdiet: TComboBox;
    chkdanger: TCheckBox;
    spnbaglim: TSpinEdit;
    pnladminuse1: TPanel;
    spnsizelim: TSpinEdit;
    lblfsp: TLabel;
    lbldiet: TLabel;
    lbldanger: TLabel;
    lblbaglim: TLabel;
    lblsizelim: TLabel;
    pnladminuse2: TPanel;
    pnloptions: TPanel;
    pnladd: TPanel;
    lbllocation: TLabel;
    pnldelete: TPanel;
    pnlview: TPanel;
    pnlupdate: TPanel;
    sbtnadd: TSpeedButton;
    sbtndelete: TSpeedButton;
    sbtnview: TSpeedButton;
    sbtnupdate: TSpeedButton;
    pnlcomment: TPanel;
    lbltypecom: TLabel;
    lbluname: TLabel;
    lblyourcom: TLabel;
    redcomments: TRichEdit;
    cmbusername: TComboBox;
    redtypecom: TRichEdit;
    pnlupload: TPanel;
    sbtnupload: TSpeedButton;
    pnlcomments: TPanel;
    sbtncomments: TSpeedButton;
    pnlsort: TPanel;
    sbtnsort: TSpeedButton;
    pnlansearch: TPanel;
    sbtnansearch: TSpeedButton;
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnuploadClick(Sender: TObject);
    procedure sbtncommentsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure sbtnaddClick(Sender: TObject);
    procedure sbtnsearchingClick(Sender: TObject);
    procedure sbtndeleteClick(Sender: TObject);
    procedure sbtnsortClick(Sender: TObject);
    procedure sbtnviewClick(Sender: TObject);
    procedure sbtnupdateClick(Sender: TObject);
    procedure sbtnansearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure comread;
  end;

var
  frmfishinfo: Tfrmfishinfo;
  objval:Tvalidation;

implementation
    uses frmfishermanhome_u, frmpolicemanhome_u, frmadminhome_u, frmlogin_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmfishinfo.comread;    //is used to read comments into rich edit
var
sline:string;
tfile:textfile;
dtoday:tDateTime;
begin

redcomments.Lines.Clear;
  if fileexists('speciescom.txt') then     //checks if file exists
  begin
    assignfile(tfile,'speciescom.txt'); //makes a copy in delphi
    reset(tfile);

    while not eof(tfile) do
    begin
      readln(tfile,sline);
      redcomments.Lines.Add(sline);
    end;
     closefile(tfile);
  end;
end;


procedure Tfrmfishinfo.FormCreate(Sender: TObject);
begin
comread;  //reads comments
end;






procedure Tfrmfishinfo.sbtnaddClick(Sender: TObject);
var
sfishsp,slocation,sdiet:string;
ibaglim,isizelim:integer;
bdanger,bflag:boolean;
begin
bflag:=True;
sfishsp:=edtspecies.Text;
slocation:=edtlocation.Text;
sdiet:=cmbdiet.Text;
bdanger:=chkdanger.Checked;
ibaglim:=spnbaglim.Value;
isizelim:=spnsizelim.Value;

if (objval.ValidString(sfishsp)=True)OR (Objval.CheckEmpty(sfishsp)=True) then
begin
Showmessage('Enter valid Species Name');
bflag:=False
end
else
begin

if (objval.ValidString(slocation)=True)OR (Objval.CheckEmpty(slocation)=True) then
begin
  Showmessage('Enter a Valid Location');
  bflag:=False;
end
else
begin


if (objval.ValidString(sdiet)=True)OR (Objval.CheckEmpty(sdiet)=True)then
begin
  Showmessage('Select a Valid Diet Option');
  bflag:=False;
end;//if sdiet valid


end;//if location valid

end;// if valid sp name


 if bflag=true then
 begin

with datamodule1 do
begin
  tblFish.Insert;
  tblFish['FishSpecies']:=edtspecies.Text;
  tblFish['MainLocation']:=edtlocation.Text;
  tblFish['Diet']:=cmbdiet.Text;
  tblFish['Endangered']:=chkdanger.Checked;
  tblFish['BagLimit']:=spnbaglim.Value;
  tblFish['SizeLimit']:=spnsizelim.Value;
  tblFish.Post;
  tblFish.Refresh;
end;
  Showmessage('Species Added Successfully!');
   dbgfish.DataSource:=DataModule1.dsrfish;
   sbtnansearch.Caption:='Search';
edtspecies.Text:='';
edtlocation.Text:='';
cmbdiet.Text:='';
chkdanger.Checked:=False;
spnbaglim.Value:=0;
spnsizelim.Value:=0;
end; //if bflag=true

end;




procedure Tfrmfishinfo.sbtnansearchClick(Sender: TObject);
var
sname:string;
begin
if sbtnansearch.Caption='Search' then
begin


//////////////////////////////////////
  sname:=Inputbox('','Enter Name Of Fish','');


 with datamodule1 do
 begin
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblFish where FishSpecies like "%'+sname+'%" ');
   qrysql.Open;
 end;
 dbgFish.DataSource:=DataModule1.dsrsql;
  sbtnansearch.Caption:='Display All';
//////////////////////////////////////


end//if caption search
else
if sbtnansearch.Caption='Display All' then
begin
 //////////////////////////////////////

   dbgfish.DataSource:=DataModule1.dsrfish;
    sbtnansearch.Caption:='Search';
     edtspecies.Text:='';
     edtlocation.Text:='';
     cmbdiet.Text:='';
     chkdanger.Checked:=False;
     spnbaglim.Value:=0;
     spnsizelim.Value:=0;


//////////////////////////////////////
end; //if caption Display All

end;

procedure Tfrmfishinfo.sbtnbackClick(Sender: TObject);
begin
  frmfishinfo.Hide;
  if frmpolicemanhome.ifishinfo=1 then
  begin
    frmfishermanhome.Show;
  end
  else
   if frmpolicemanhome.ifishinfo=2 then
  begin
    frmpolicemanhome.Show;
  end
  else
  if frmpolicemanhome.ifishinfo=3 then
  begin
   frmadminhome.show
  end;
    cmbusername.Text:='';
    redtypecom.Lines.Clear;
    edtsearch.Text:='';
    redoutput.Lines.Clear;
end;

procedure Tfrmfishinfo.sbtncommentsClick(Sender: TObject);
begin
if sbtncomments.Caption='View Comments' then
begin
  pnlspecies.Hide;
  pnlcomment.Show;
  sbtncomments.Caption:='View Fish';
end
else
if sbtncomments.Caption='View Fish' then
begin
  pnlspecies.Show;
  pnlcomment.Hide;
  sbtncomments.Caption:='View Comments';
end;
end;

procedure Tfrmfishinfo.sbtndeleteClick(Sender: TObject);
begin
with datamodule1 do
begin
  tblFish.Delete;
  tblFish.Refresh;
end;
dbgfish.DataSource:=DataModule1.dsrfish;
sbtnansearch.Caption:='Search';
showmessage('Species Removed');
end;



procedure Tfrmfishinfo.sbtnhelpClick(Sender: TObject);
begin
  frmhelp.Show;
  if frmpolicemanhome.ifishinfo=1 then
  begin
    frmhelp.pnladminhelp.Hide;
    frmhelp.pnlpmhelp.Hide;
    frmhelp.pnlfmhelp.Show;
  end
  else
   if frmpolicemanhome.ifishinfo=2 then
  begin
    frmhelp.pnladminhelp.Hide;
    frmhelp.pnlfmhelp.Hide;
    frmhelp.pnlpmhelp.Show;
  end
  else
  if frmpolicemanhome.ifishinfo=3 then
  begin
   frmhelp.pnlfmhelp.Hide;
   frmhelp.pnlpmhelp.Hide;
   frmhelp.pnladminhelp.Show;
  end;
end;

procedure Tfrmfishinfo.sbtnsearchingClick(Sender: TObject);
var
sname,syes:string;
bfound:boolean;
begin
sname:=edtsearch.Text;
redoutput.Lines.Clear;
bfound:=False;

with datamodule1 do
begin
  tblFish.first;
  while (not tblFish.eof) AND (bfound=False) do
  begin
    if sname=tblFish['FishSpecies'] then
    begin
     bfound:=True;
    ////////////////////
    if tblFish['Endangered']=True then
    begin
      syes:='Yes';
    end
    else
    begin
      syes:='No';
    end;
    //////////////
      redoutput.Lines.Add(tblFish['FishSpecies']);
      redoutput.Lines.Add(tblFish['FishSpecies']+' Is Mainly Located at: '+tblFish['MainLocation']);
      redoutput.Lines.Add('It Usually Eats: '+tblFish['Diet']);
      redoutput.Lines.Add('Is It Endangered?: '+syes);
      redoutput.Lines.Add('You can only catch '+IntToStr(tblFish['BagLimit'])+' Per Person Per Day.');
      redoutput.Lines.Add('This fishs Size Limit Is '+IntToStr(tblFish['SizeLimit'])+'cm');

    end; //if equal
      tblFish.Next;

  end; //while

end; //with
if bfound=False then
    begin
      showmessage('Cant find fish');
    end;
end;



procedure Tfrmfishinfo.sbtnsortClick(Sender: TObject);
begin
dbgfish.DataSource:=DataModule1.dsrfish;
with datamodule1 do
begin
  tblfish.Sort:='FishSpecies';
end;
end;

procedure Tfrmfishinfo.sbtnupdateClick(Sender: TObject);
var
sfishsp,slocation,sdiet:string;
ibaglim,isizelim:integer;
bdanger,bflag:boolean;
begin
bflag:=True;
sfishsp:=edtspecies.Text;
slocation:=edtlocation.Text;
sdiet:=cmbdiet.Text;
bdanger:=chkdanger.Checked;
ibaglim:=spnbaglim.Value;
isizelim:=spnsizelim.Value;

if (objval.ValidString(sfishsp)=True)OR (Objval.CheckEmpty(sfishsp)=True) then
begin
Showmessage('Enter valid Species Name');
bflag:=False
end
else
begin

if (objval.ValidString(slocation)=True)OR (Objval.CheckEmpty(slocation)=True) then
begin
  Showmessage('Enter a Valid Location');
  bflag:=False;
end
else
begin


if (objval.ValidString(sdiet)=True)OR (Objval.CheckEmpty(sdiet)=True)then
begin
  Showmessage('Select a Valid Diet Option');
  bflag:=False;
end;//if sdiet valid


end;//if location valid

end;// if valid sp name


 if bflag=true then
 begin

with datamodule1 do
begin
  tblFish.edit;
  tblFish['FishSpecies']:=edtspecies.Text;
  tblFish['MainLocation']:=edtlocation.Text;
  tblFish['Diet']:=cmbdiet.Text;
  tblFish['Endangered']:=chkdanger.Checked;
  tblFish['BagLimit']:=spnbaglim.Value;
  tblFish['SizeLimit']:=spnsizelim.Value;
  tblFish.Post;
  tblFish.Refresh;
end;
  Showmessage('Species Updated Successfully!');

edtspecies.Text:='';
edtlocation.Text:='';
cmbdiet.Text:='';
chkdanger.Checked:=False;
spnbaglim.Value:=0;
spnsizelim.Value:=0;
end; //if bflag=true

end;


procedure Tfrmfishinfo.sbtnuploadClick(Sender: TObject);
var
suname,sline:string;
tfile:textfile;
bfound,bflag:boolean;
ilines:integer;
i: Integer;
dtoday:TDateTime;
begin
bfound:=False;
bflag:=False;
ilines:=redtypecom.Lines.Count;
dtoday:=Now;

  if cmbusername.text='Your Username' then
  begin
    suname:=frmlogin.spubuname+' - '+'('+frmlogin.sstatus+')';
    bfound:=True;
      ////////////////////
  if (ilines<8) then
  begin

  if (ilines>0) then
  begin
    bflag:=True;
  end
  else
  begin
    showmessage('Please Enter A Comment To Proceed');
  end;

  end
  else
  begin
    showmessage('Comment too long, try shortening to proceed');
  end;
  ////////////////////
  end
  else
  if cmbusername.text='Anonymous' then
  begin
   suname:='Anonymous';
   bfound:=True;
     ////////////////////
  if (ilines<8) then
  begin

  if (ilines>0) then
  begin
    bflag:=True;
  end
  else
  begin
    showmessage('Please Enter A Comment To Proceed');
  end;

  end
  else
  begin
    showmessage('Comment too long, try shortening to proceed');
  end;
  ////////////////////
  end
  else
  begin
    Showmessage('Please select username status');
  end;

  //////////////////////////////////////////////////////////
   if (bfound=True) AND (bflag=True) then
   begin
  if fileexists('speciescom.txt') then
  begin
    sline:=suname+':';
    assignfile(tfile,'speciescom.txt');
    append(tfile);
    writeln(tfile,sline);
    closefile(tfile);
  end;//if file exists
  ////////////////////
    sline:='';
 ////////////////////
    if fileexists('speciescom.txt') then
  begin
     assignfile(tfile,'speciescom.txt');
     append(tfile);

     for i := 1 to ilines do
begin
   sline:=redtypecom.Lines[i-1];
    writeln(tfile,sline);
end;//for loop
    sline:=DateToStr(dtoday)+' '+TimeToStr(dtoday);
    writeln(tfile,sline);
    sline:=' ';//creates a space inbetween comments
    writeln(tfile,sline);
    closefile(tfile);

  end;//if file exists
    showmessage('Comment Uploaded');
    redtypecom.Lines.Clear;


   end;//if bfound bflag

   comread;
end;






procedure Tfrmfishinfo.sbtnviewClick(Sender: TObject);
begin

with datamodule1 do
begin

edtspecies.Text:=tblFish['FishSpecies'];
edtlocation.Text:=tblFish['MainLocation'];
cmbdiet.Text:=tblFish['Diet'];
chkdanger.Checked:=tblFish['Endangered'];
spnbaglim.Value:=tblFish['BagLimit'];
spnsizelim.Value:=tblFish['SizeLimit'];
end;//with datamod


end;

end.
