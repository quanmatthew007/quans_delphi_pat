unit frmbeachinfo_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons, Spin, StdCtrls, ComCtrls, Grids, DBGrids, dmPAT23_u, Validation_U;

type
  Tfrmbeachinfo = class(TForm)
    pnlbibckgd: TPanel;
    pnllogo: TPanel;
    imglogo: TImage;
    imgbibckgd: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnldata: TPanel;
    dbgbeaches: TDBGrid;
    pnloutput: TPanel;
    redoutput: TRichEdit;
    pnlsearch: TPanel;
    lblsearchtitle: TLabel;
    lblsearch: TLabel;
    edtsearch: TEdit;
    pnlsearching: TPanel;
    sbtnsearching: TSpeedButton;
    pnladminuse1: TPanel;
    lblbid: TLabel;
    lbllocation: TLabel;
    lblclean: TLabel;
    lblallowed: TLabel;
    lblmaxacc: TLabel;
    lblbname: TLabel;
    chkallowed: TCheckBox;
    cmbtype: TComboBox;
    edtbid: TEdit;
    edtbname: TEdit;
    spncleanlvl: TSpinEdit;
    spnmaxacc: TSpinEdit;
    pnladminuse2: TPanel;
    pnloptions: TPanel;
    pnladd: TPanel;
    sbtnadd: TSpeedButton;
    pnldelete: TPanel;
    sbtndelete: TSpeedButton;
    pnlview: TPanel;
    sbtnview: TSpeedButton;
    pnlupdate: TPanel;
    sbtnupdate: TSpeedButton;
    lblbtype: TLabel;
    lbldangerlvl: TLabel;
    edtlocation: TEdit;
    spndanger: TSpinEdit;
    lblbeachinfo: TLabel;
    pnlcomments: TPanel;
    sbtncomments: TSpeedButton;
    pnlcomment: TPanel;
    redcomments: TRichEdit;
    lbltypecom: TLabel;
    lbluname: TLabel;
    cmbusername: TComboBox;
    lblyourcom: TLabel;
    redtypecom: TRichEdit;
    pnlupload: TPanel;
    sbtnupload: TSpeedButton;
    pnlsort: TPanel;
    sbtnsort: TSpeedButton;
    pnlansearch: TPanel;
    sbtnansearch: TSpeedButton;
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtncommentsClick(Sender: TObject);
    procedure sbtnuploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure sbtnaddClick(Sender: TObject);
    procedure sbtndeleteClick(Sender: TObject);
    procedure sbtnviewClick(Sender: TObject);
    procedure sbtnupdateClick(Sender: TObject);
    procedure sbtnsearchingClick(Sender: TObject);
    procedure sbtnsortClick(Sender: TObject);
    procedure sbtnansearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure readcom;
    procedure addbeach;
    procedure updbeach;
    procedure searchbeach;
  end;

var
  frmbeachinfo: Tfrmbeachinfo;
  objval:Tvalidation;
implementation
     uses frmfishermanhome_u, frmadminhome_u, frmlogin_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmbeachinfo.addbeach;
var
sid,sname,sloca,stype:string;
ilength,iclean,idanger,i,imac,icount:integer;
bfa,bfound:Boolean;
begin
bfound:=True;
sid:=edtbid.Text;  //extract data
sname:=edtbname.Text;
sloca:=edtlocation.Text;
iclean:=spncleanlvl.Value;
bfa:=chkallowed.Checked;
imac:=spnmaxacc.Value;
stype:=cmbtype.Text;
idanger:=spndanger.Value;



 if  objval.Validpkid(sid)=true then
 begin

 if (objval.ValidString(sname)=true)or(objval.CheckEmpty(sname)=true) then
 begin
  showmessage('Enter A Valid Name');
  bfound:=False;
 end
 else
 begin

 if (objval.ValidString(sloca)=true)or(objval.CheckEmpty(sloca)=true)  then
 begin
   showmessage('Enter a Valid Location');
   bfound:=False;
 end
 else
 begin

 if (objval.ValidString(stype)=true)or(objval.CheckEmpty(stype)=true)  then
 begin
    showmessage('Please select a valid beach type');
    bfound:=False;

 end;//if stype valid


 end;//if location valid

 end;  //if name valid


 end //if id valid
 else
 begin
   showmessage('Beach ID must be made up of 2 letters and 3 numbers');
   bfound:=False;
 end;



  if bfound=True then
  begin
    with datamodule1 do
    begin
    tblBeaches.Insert;
    tblBeaches['BeachID']:=sid;
    tblBeaches['BeachName']:=sname;
    tblBeaches['Location']:=sloca;
    tblBeaches['Clenlinesslevel']:=iclean;
    tblBeaches['Fishing']:=bfa;
    tblBeaches['MaxAccomodation']:=imac;
    tblBeaches['BeachType']:=stype;
    tblBeaches['DangerLevel']:=idanger;
    tblBeaches.Post;
    tblBeaches.Refresh;

    end;//with datamod
    showmessage('Beach added sucessfully');
    dbgbeaches.DataSource:=DataModule1.dsrbeaches;
     edtbid.Text:='';  //Initializez components for next execution
     edtbname.Text:='';
     edtlocation.Text:='';
     spncleanlvl.Value:=1;
     chkallowed.Checked:=False;
     spnmaxacc.Value:=0;
     cmbtype.Text:='';
     spndanger.Value:=1;

  end;// if bfound true
end;

procedure Tfrmbeachinfo.FormCreate(Sender: TObject);
begin
readcom;   //reads comments into richedit
end;

procedure Tfrmbeachinfo.readcom;//reads comments into richedit to be seen
var
sline:string;
tfile:textfile;
dtoday:tDateTime;
begin

redcomments.Lines.Clear;
  if fileexists('beachcom.txt') then
  begin
    assignfile(tfile,'beachcom.txt');
    reset(tfile);

    while not eof(tfile) do
    begin
      readln(tfile,sline);
      redcomments.Lines.Add(sline);
    end;
     closefile(tfile);
  end;
end;
//////////////////////////////////////////
procedure Tfrmbeachinfo.sbtnaddClick(Sender: TObject);
begin
addbeach;

end;
////////////////


procedure Tfrmbeachinfo.sbtnansearchClick(Sender: TObject);
var
sname:string;
begin
if sbtnansearch.Caption='Search' then
begin


//////////////////////////////////////
  sname:=Inputbox('','Enter Name Of Beach','');


 with datamodule1 do
 begin
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblBeaches where BeachName like "%'+sname+'%" ');
   qrysql.Open;
 end;
 dbgbeaches.DataSource:=DataModule1.dsrsql;
  sbtnansearch.Caption:='Display All';
//////////////////////////////////////


end//if caption search
else
if sbtnansearch.Caption='Display All' then
begin
 //////////////////////////////////////
 dbgbeaches.DataSource:=DataModule1.dsrbeaches;

     edtbid.Text:='';  //Initializez components for next execution
     edtbname.Text:='';
     edtlocation.Text:='';
     spncleanlvl.Value:=1;
     chkallowed.Checked:=False;
     spnmaxacc.Value:=0;
     cmbtype.Text:='';
     spndanger.Value:=1;

//////////////////////////////////////
end; //if caption Display All

end;


procedure Tfrmbeachinfo.sbtnbackClick(Sender: TObject);
begin
 frmbeachinfo.Hide;
 if frmfishermanhome.ibeachin=1 then
 begin
    frmfishermanhome.Show;
 end
 else
 if frmfishermanhome.ibeachin=2 then
 begin
   frmadminhome.Show;
 end;

 edtsearch.Text:='';
 redoutput.Lines.Clear;
 redtypecom.Lines.Clear;
 cmbusername.Text:='';

end;

procedure Tfrmbeachinfo.sbtncommentsClick(Sender: TObject);
begin
if sbtncomments.Caption='View Comments' then
begin
  pnldata.Hide;
  pnlcomment.Show;
  sbtncomments.Caption:='View Beaches';
end
else
if sbtncomments.Caption='View Beaches' then
begin
  pnldata.Show;
  pnlcomment.Hide;
  sbtncomments.Caption:='View Comments';
end;


end;

procedure Tfrmbeachinfo.sbtndeleteClick(Sender: TObject);
begin
with datamodule1 do
begin
  tblBeaches.Delete;
  tblBeaches.Refresh;
  Showmessage('Beach Deleted Successfully');
end;
  sbtnansearch.Caption:='Search';
  dbgbeaches.DataSource:=DataModule1.dsrbeaches;
end;

procedure Tfrmbeachinfo.sbtnhelpClick(Sender: TObject);
begin
 frmhelp.Show;
 if frmfishermanhome.ibeachin=1 then
 begin
    frmhelp.pnlpmhelp.Hide;
    frmhelp.pnladminhelp.Hide;
    frmhelp.pnlfmhelp.Show;
 end
 else
 if frmfishermanhome.ibeachin=2 then
 begin
   frmhelp.pnlpmhelp.Hide;
   frmhelp.pnlfmhelp.hide;
   frmhelp.pnladminhelp.Show;
 end;
end;

procedure Tfrmbeachinfo.sbtnsearchingClick(Sender: TObject);
begin
searchbeach;
end;

procedure Tfrmbeachinfo.sbtnsortClick(Sender: TObject);
begin

  dbgbeaches.DataSource:=DataModule1.dsrbeaches;
with datamodule1 do
begin
 tblBeaches.Sort:='BeachName';
end; //
end;

procedure Tfrmbeachinfo.sbtnupdateClick(Sender: TObject);
begin
updbeach;

end;
procedure Tfrmbeachinfo.sbtnuploadClick(Sender: TObject);
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
  ///////////////////////////////////////////////////////////

   if (bfound=True) AND (bflag=True) then
   begin
  if fileexists('beachcom.txt') then
  begin
    sline:=suname+':';
    assignfile(tfile,'beachcom.txt');
    append(tfile);
    writeln(tfile,sline);
    closefile(tfile);
  end;//if file exists
  ////////////////////
    sline:='';
 ////////////////////
    if fileexists('beachcom.txt') then
  begin
     assignfile(tfile,'beachcom.txt');
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
    readcom;
   end;//if bfound bflag


end;

procedure Tfrmbeachinfo.sbtnviewClick(Sender: TObject);
begin
with datamodule1 do
begin
     edtbid.Text:=tblBeaches['BeachID'];
     edtbname.Text:=tblBeaches['BeachName'];
     edtlocation.Text:=tblBeaches['Location'];
     spncleanlvl.Value:=tblBeaches['Clenlinesslevel'];
     chkallowed.Checked:=tblBeaches['Fishing'];
     spnmaxacc.Value:=tblBeaches['MaxAccomodation'];
     cmbtype.Text:=tblBeaches['BeachType'];
     spndanger.Value:=tblBeaches['DangerLevel'];
end;//with data mod

if sbtnansearch.Caption='Display All' then
begin
dbgbeaches.DataSource:=DataModule1.dsrsql;
end
else
begin
dbgbeaches.DataSource:=DataModule1.dsrbeaches;
end;
end;

procedure Tfrmbeachinfo.searchbeach;
Var
sname,syes:string;
bfound:boolean;
begin
sname:=edtsearch.Text;
redoutput.Lines.Clear;
bfound:=False;
with datamodule1 do
begin
tblBeaches.First;

   while (not tblBeaches.eof) AND (bfound=False) do
   begin

    if sname=tblBeaches['BeachName'] then
    begin
     bfound:=True;
     //////////////

      if tblBeaches['Fishing']=True then
    begin
      syes:='Yes';
    end
    else
    begin
      syes:='No';
    end;
    /////////////

    redoutput.Lines.Add(tblBeaches['BeachName']);
    redoutput.Lines.Add(tblBeaches['BeachName']+' Is Located In: '+tblBeaches['Location']+'.');
    redoutput.Lines.Add('This Beach Is Rated '+IntToStr(tblBeaches['Clenlinesslevel'])+'/10 For Clenliness.' );
    redoutput.Lines.Add('This Beach Is Rated '+IntToStr(tblBeaches['DangerLevel'])+'/10 For Danger.' );
    redoutput.Lines.Add('Is Fising Allowed: '+syes);
    redoutput.Lines.Add('The Max People That Can Fit In This Beach Is: '+IntToStr(tblBeaches['MaxAccomodation'])+' people.');
    redoutput.Lines.Add('The Topography of this beach is: '+tblBeaches['BeachType']+'.');
    redoutput.Lines.Add(' ');
    redoutput.Lines.Add('Remember, When Visiting A Beach, Only Leave Your Footprints Behind');
   end; //if sname true
     tblBeaches.Next;

   end; //while


end;//with data mod

if bfound=False then
begin
  Showmessage('Cant Find Entered Beach');
end;

 ///////////////////////
end;

procedure Tfrmbeachinfo.updbeach;
var
sid,sname,sloca,stype:string;
ilength,iclean,idanger,i,imac,icount:integer;
bfa,bfound:Boolean;
begin
bfound:=True;
sid:=edtbid.Text;  //extract data
sname:=edtbname.Text;
sloca:=edtlocation.Text;
iclean:=spncleanlvl.Value;
bfa:=chkallowed.Checked;
imac:=spnmaxacc.Value;
stype:=cmbtype.Text;
idanger:=spndanger.Value;

 if  objval.Validpkid(sid)=true then
 begin

 if (objval.ValidString(sname)=true)or(objval.CheckEmpty(sname)=true) then
 begin
  showmessage('Enter A Valid Name');
  bfound:=False;
 end
 else
 begin

 if (objval.ValidString(sloca)=true)or(objval.CheckEmpty(sloca)=true)  then
 begin
   showmessage('Enter a Valid Location');
   bfound:=False;
 end
 else
 begin

 if (objval.ValidString(stype)=true)or(objval.CheckEmpty(stype)=true)  then
 begin
    showmessage('Please select a valid beach type');
    bfound:=False;

 end;//if stype valid


 end;//if location valid

 end;  //if name valid


 end //if id valid
 else
 begin
   showmessage('Beach ID must be made up of 2 letters and 3 numbers');
   bfound:=False;
 end;



  if bfound=True then
  begin
    with datamodule1 do
    begin
    tblBeaches.Edit;
    tblBeaches['BeachID']:=sid;
    tblBeaches['BeachName']:=sname;
    tblBeaches['Location']:=sloca;
    tblBeaches['Clenlinesslevel']:=iclean;
    tblBeaches['Fishing']:=bfa;
    tblBeaches['MaxAccomodation']:=imac;
    tblBeaches['BeachType']:=stype;
    tblBeaches['DangerLevel']:=idanger;
    tblBeaches.Post;
    tblBeaches.Refresh;

    end;//with datamod
    showmessage('Beach Updated sucessfully');
     dbgbeaches.DataSource:=DataModule1.dsrbeaches;
     edtbid.Text:='';  //Initializez components for next execution
     edtbname.Text:='';
     edtlocation.Text:='';
     spncleanlvl.Value:=1;
     chkallowed.Checked:=False;
     spnmaxacc.Value:=0;
     cmbtype.Text:='';
     spndanger.Value:=1;
  end;// if bfound true
end;

end.
