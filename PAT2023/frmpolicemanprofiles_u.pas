unit frmpolicemanprofiles_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, jpeg, ExtCtrls, ComCtrls, dmPAT23_u, Validation_U;

type
  Tfrmpolicemanprofiles = class(TForm)
    pnlbckgd: TPanel;
    imgbckgd: TImage;
    lbltitle: TLabel;
    pnllogo: TPanel;
    imglogo: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnldata: TPanel;
    lblpmid: TLabel;
    lblpmname: TLabel;
    lblpmsurname: TLabel;
    lblpmcontactno: TLabel;
    dbgpmpro1: TDBGrid;
    pnladminuse2: TPanel;
    pnlchanges: TPanel;
    pnladd: TPanel;
    sbtnadd: TSpeedButton;
    pnldelete: TPanel;
    sbtndelete: TSpeedButton;
    pnlview: TPanel;
    sbtnview: TSpeedButton;
    pnlupdate: TPanel;
    sbtnupdate: TSpeedButton;
    edtpmid: TEdit;
    edtpmname: TEdit;
    edtpmsurname: TEdit;
    edtcontactno: TEdit;
    pnlviewduties: TPanel;
    sbtnduties: TSpeedButton;
    pnlduties: TPanel;
    dbgpmpro2: TDBGrid;
    lbldutyarea: TLabel;
    edtdutyarea: TEdit;
    dtpdutydate: TDateTimePicker;
    lbldutydate: TLabel;
    lblpmid2: TLabel;
    edtpmid2: TEdit;
    dbgduty: TDBGrid;
    pnloptions: TPanel;
    pnlsearching: TPanel;
    sbtnsearching: TSpeedButton;
    pnlsort: TPanel;
    sbtnsort: TSpeedButton;
    pnldutieops: TPanel;
    pnladddut: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    sbtnadddut: TSpeedButton;
    Sbtndeleteduty: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    redoutput: TRichEdit;
    dbgbeach: TDBGrid;
    pnlextoptions: TPanel;
    pnlsearch: TPanel;
    pnlserpm: TPanel;
    sbtndisplay: TSpeedButton;
    SpeedButton3: TSpeedButton;
    pnlsearchduties: TPanel;
    sbtnsearchduty: TSpeedButton;
    procedure sbtndutiesClick(Sender: TObject);
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure sbtnaddClick(Sender: TObject);
    procedure sbtndeleteClick(Sender: TObject);
    procedure sbtnviewClick(Sender: TObject);
    procedure sbtnupdateClick(Sender: TObject);
    procedure sbtnsortClick(Sender: TObject);
    procedure sbtnsearchingClick(Sender: TObject);
    procedure sbtnadddutClick(Sender: TObject);
    procedure SbtndeletedutyClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sbtndisplayClick(Sender: TObject);
    procedure sbtnsearchdutyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmpolicemanprofiles: Tfrmpolicemanprofiles;
   objval:Tvalidation;
implementation


     uses frmadminhome_u, frmhelp_u;
{$R *.dfm}



procedure Tfrmpolicemanprofiles.sbtnaddClick(Sender: TObject);
var
sid,sname,ssurname,scon:string;
bfound:boolean;
ilength,icount,i:integer;
begin
bfound:=True;
sid:=edtpmid.Text;//extracts data from components
sname:=edtpmname.Text;
ssurname:=edtpmsurname.text;
scon:=edtcontactno.Text;
//////////////////////
ilength:=length(sid);
  for i :=1 to ilength do
  begin
    if sid[i] IN ['A' .. 'Z', 'a' .. 'z']then
    begin
      inc(icount);
    end;//if in

  end;//for loop
///////////////

if  (ilength=5) and (icount=2) then
begin

if (objval.ValidString(sname)=True)or(objval.CheckEmpty(sname)=True) then
begin
 Showmessage('Enter A Valid Name');
 bfound:=False;
end
else
begin

if (objval.ValidString(ssurname)=True)or(objval.CheckEmpty(ssurname)=True) then
begin
  Showmessage('Enter A Valid Surame');
 bfound:=False;
end
else
begin

if objval.ValidContact(scon)=True then
begin
  showmessage('Enter a Valid Contact Number');
  bfound:=False;
end;


end;// if valid surname


end;//if name valid

end //if sid valid
else
begin
  showmessage('Enter a valid ID Consisting Of 3 Numbers And 2 Letters');
  bfound:=False;
end;


if bfound=True then
begin

with datamodule1 do
begin

tblPolicemen.Insert;
tblpolicemen['PolicemanID']:= sid;
tblpolicemen['PolicemanName']:= sname;
tblpolicemen['PolicemanSurname']:= ssurname;
tblpolicemen['PmContactNO']:= scon;
 tblpolicemen.Post;
 tblpolicemen.Refresh;
end;//with datamod

showmessage('Policeman Added Successfully');
dbgpmpro1.DataSource:=DataModule1.dsrpolicemen;
edtpmid.Text:='';//prepares componenets for next use
edtpmname.Text:='';
edtpmsurname.text:='';
edtcontactno.Text:='';

end;//if bfound true

end;




procedure Tfrmpolicemanprofiles.sbtnadddutClick(Sender: TObject);
var
sarea,spmid:string;
ddate:String;
bfound:boolean;
begin
sarea:=edtdutyarea.Text;
ddate:=DateToStr(dtpdutydate.Date);
spmid:=edtpmid2.Text;
bfound:=True;
ddate:=Copy(ddate,1,10);
dbgpmpro2.DataSource:=Datamodule1.dsrpolicemen;
if objval.Validpkid(sarea)=False then
begin
showmessage('Enter a valid area');
 bfound:=False;
end
else
begin
  if objval.Validpkid(spmid)=False then
  begin
    showmessage('Enter A Valid Policeman ID');
    bfound:=False;

  end;//if pm id valid

end;// if sarea valid


if bfound=True  then
begin
  with datamodule1 do
  begin
   tblDuties.Insert;

   tblDuties['DutyArea']:=sarea;
   tblDuties['DutyDate']:=StrToDate(ddate);
   tblDuties['PolicemanID']:= spmid;
   tblDuties.Post;
   tblDuties.Refresh;

  end;//with datamodule do
  Showmessage('Duty Sucessfully Added');

   edtdutyarea.Text:='';
   dtpdutydate.Date:=NOW;
   edtpmid2.Text:='';
end; //if bfound true


end;

procedure Tfrmpolicemanprofiles.sbtnbackClick(Sender: TObject);
begin
frmpolicemanprofiles.Hide;
frmadminhome.show;
end;


procedure Tfrmpolicemanprofiles.sbtndeleteClick(Sender: TObject);
begin
with datamodule1 do
begin
   tblPolicemen.Delete;
   tblpolicemen.Refresh;
   showmessage('Policeman Removed Successfully');
end;//with data mod
dbgpmpro1.DataSource:=DataModule1.dsrpolicemen;
end;


procedure Tfrmpolicemanprofiles.SbtndeletedutyClick(Sender: TObject);
begin
dbgpmpro2.DataSource:=Datamodule1.dsrpolicemen;
with datamodule1 do
begin
  tblDuties.Delete;
  tblDuties.Refresh;
  showmessage('Duty Deleted Sucessfully');
end;    //with datamod
end;

procedure Tfrmpolicemanprofiles.sbtndisplayClick(Sender: TObject);
begin
dbgpmpro2.DataSource:=Datamodule1.dsrpolicemen;
 dbgduty.DataSource:=Datamodule1.dsrduties;

redoutput.Clear;
with datamodule1 do
begin

 tblpolicemen.first;//starts search at top
 while not tblpolicemen.eof do
 begin
 redoutput.Lines.Add(tblpolicemen['PolicemanName']+' '+tblpolicemen['PolicemanSurname']+' Was On Duty On:');

 tblDuties.First;  //starts search at top
 while not tblDuties.eof do
 begin
    if tblPolicemen['PolicemanID']=tblDuties['PolicemanID'] then
    begin

       tblBeaches.First; //starts search at top
            while not tblBeaches.eof do
            begin
               if tblDuties['DutyArea']=tblBeaches['BeachID'] then
               begin

              redoutput.Lines.Add(DateToStr(tblduties['DutyDate'])+' at '+tblBeaches['BeachName']);

               end;//if duties=beach

              tblbeaches.Next;  //goes to next record

            end;// while not eof beaches

    end;
     tblDuties.Next;//goes to next record
 end;//while duties
   redoutput.Lines.Add('');
    tblPolicemen.Next;//goes to next record
 end;//while policemen

end;//with

end;

procedure Tfrmpolicemanprofiles.sbtndutiesClick(Sender: TObject);
begin
if sbtnduties.Caption='View Duties' then//changes panels
begin
  sbtnduties.Caption:='View Profiles';
  pnlduties.Show;
  pnldata.Hide;

end
else
if sbtnduties.Caption='View Profiles' then //changes panels
begin
 sbtnduties.Caption:='View Duties';
  pnlduties.hide;
  pnldata.show;
end;

end;

procedure Tfrmpolicemanprofiles.sbtnhelpClick(Sender: TObject);
begin
 frmhelp.Show;           //shows help form
 frmhelp.tbspoliceman.Hide;
 frmhelp.pnlpmhelp.Hide;
 frmhelp.tbsfisherman.Hide;
 frmhelp.pnlfmhelp.Hide;
 frmhelp.pnladminhelp.Show;
end;

procedure Tfrmpolicemanprofiles.sbtnsearchdutyClick(Sender: TObject);
var
sid:string;
begin
    redoutput.Lines.Clear;

    with datamodule1 do
    begin
      dbgduty.DataSource:=Datamodule1.dsrsql;
      sid:=InputBox('','Enter ID Of Policeman','');  //input for whta to search for
      qrysql.Close;
      qrysql.SQL.Clear;
      qrysql.SQL.Add('Select * from tblDuties where PolicemanID="'+sid+'"');
      qrysql.Open;

      tblPolicemen.First;
      while not tblPolicemen.eof do
      begin
        if tblPolicemen['PolicemanID']=sid then  //checks for what to display
        begin
          Redoutput.Lines.Add(tblpolicemen['PolicemanName']+' '+tblpolicemen['PolicemanSurname']+' Was On Duty On:');

          tblduties.First;
          while not tblDuties.eof do
          begin
            if tblDuties['PolicemanID']=tblPolicemen['PolicemanID'] then
            begin

            tblBeaches.First;
            while not tblBeaches.eof do
            begin
               if tblDuties['DutyArea']=tblBeaches['BeachID'] then
               begin

              redoutput.Lines.Add(DateToStr(tblduties['DutyDate'])+' at '+tblBeaches['BeachName']);

               end;//if duties=beach

              tblbeaches.Next;

            end;// while not eof beaches

            end; //if duties=policemen
            tblduties.Next;
          end;// while duties

        end; //if = sid
        tblPolicemen.Next;
      end;   //while not eof policemen


    end;//with data mod
end;

procedure Tfrmpolicemanprofiles.sbtnsearchingClick(Sender: TObject);
var
sname:string;
begin
if sbtnsearching.Caption='Search' then
begin


//////////////////////////////////////
  sname:=Inputbox('','Enter Name Of Policeman','');


 with datamodule1 do
 begin
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblPolicemen where PolicemanName like "%'+sname+'%" ');
   qrysql.Open;
 end;//with data module
 dbgpmpro1.DataSource:=DataModule1.dsrsql;
  sbtnsearching.Caption:='Display All';
//////////////////////////////////////


end//if caption search
else
if sbtnsearching.Caption='Display All' then
begin
 //////////////////////////////////////

dbgpmpro1.DataSource:=DataModule1.dsrpolicemen;
sbtnsearching.Caption:='Search';
edtpmid.Text:='';  //prepares componenets for next use
edtpmname.Text:='';
edtpmsurname.text:='';
edtcontactno.Text:='';
//////////////////////////////////////
end; //if caption Display All

end;

procedure Tfrmpolicemanprofiles.sbtnsortClick(Sender: TObject);
begin
dbgpmpro1.DataSource:=DataModule1.dsrpolicemen;
with datamodule1 do
begin
  tblPolicemen.Sort:='PolicemanName';
end;
end;

procedure Tfrmpolicemanprofiles.sbtnupdateClick(Sender: TObject);
var
sid,sname,ssurname,scon:string;
bfound:boolean;
ilength,icount,i:integer;
begin
bfound:=True;
sid:=edtpmid.Text;//extracts data from components
sname:=edtpmname.Text;
ssurname:=edtpmsurname.text;
scon:=edtcontactno.Text;
//////////////////////
ilength:=length(sid);
  for i :=1 to ilength do
  begin
    if sid[i] IN ['A' .. 'Z', 'a' .. 'z']then
    begin
      inc(icount);
    end;//if in

  end;//for loop
///////////////

if  (ilength=5) and (icount=2) then
begin

if (objval.ValidString(sname)=True)or(objval.CheckEmpty(sname)=True) then
begin
 Showmessage('Enter A Valid Name');
 bfound:=False;
end
else
begin

if (objval.ValidString(ssurname)=True)or(objval.CheckEmpty(ssurname)=True) then
begin
  Showmessage('Enter A Valid Surame');
 bfound:=False;
end
else
begin

if objval.ValidContact(scon)=True then
begin
  showmessage('Enter a Valid Contact Number');
  bfound:=False;
end;


end;// if valid surname


end;//if name valid

end //if sid valid
else
begin
  showmessage('Enter a valid ID Consisting Of 3 Numbers And 2 Letters');
  bfound:=False;
end;


if bfound=True then
begin

with datamodule1 do
begin

tblPolicemen.edit;
tblpolicemen['PolicemanID']:= sid;
tblpolicemen['PolicemanName']:= sname;
tblpolicemen['PolicemanSurname']:= ssurname;
tblpolicemen['PmContactNO']:= scon;
tblpolicemen.Post;
tblpolicemen.Refresh;
end;//with datamod

showmessage('Policeman Updated Successfully');
dbgpmpro1.DataSource:=DataModule1.dsrpolicemen;
edtpmid.Text:='';//prepares componenets for next use
edtpmname.Text:='';
edtpmsurname.text:='';
edtcontactno.Text:='';

end;//if bfound true

end;

procedure Tfrmpolicemanprofiles.sbtnviewClick(Sender: TObject);
begin
with datamodule1 do
begin
edtpmid.Text:=tblpolicemen['PolicemanID'];
edtpmname.Text:=tblpolicemen['PolicemanName'];
edtpmsurname.text:=tblpolicemen['PolicemanSurname'];
edtcontactno.Text:=tblpolicemen['PmContactNO'];
end; // with data mod
end;

procedure Tfrmpolicemanprofiles.SpeedButton1Click(Sender: TObject);
begin
with datamodule1 do
begin
 edtdutyarea.Text:=tblDuties['DutyArea'];
 dtpdutydate.Date:=tblDuties['DutyDate'];
 edtpmid2.Text:=tblDuties['PolicemanID'];
end;  //with datamod

end;

procedure Tfrmpolicemanprofiles.SpeedButton2Click(Sender: TObject);
var
sarea,spmid:string;
ddate:String;
bfound:boolean;
begin
dbgpmpro2.DataSource:=Datamodule1.dsrpolicemen;
sarea:=edtdutyarea.Text;
ddate:=DateToStr(dtpdutydate.Date);
spmid:=edtpmid2.Text;
bfound:=True;
ddate:=Copy(ddate,1,10);

if objval.Validpkid(sarea)=false then
begin
showmessage('Enter a valid area');
 bfound:=False;
end
else
begin
  if objval.Validpkid(spmid)=False then
  begin
    showmessage('Enter A Valid Policeman ID');
    bfound:=False;

  end;//if pm id valid

end;// if sarea valid


if bfound=True  then
begin
  with datamodule1 do
  begin
   tblDuties.edit;

   tblDuties['DutyArea']:=sarea;
   tblDuties['DutyDate']:=StrToDate(ddate);
   tblDuties['PolicemanID']:= spmid;
   tblDuties.Post;
   tblDuties.Refresh;

  end;//with datamodule do
  Showmessage('Duty Sucessfully Updated');

   edtdutyarea.Text:='';
   dtpdutydate.Date:=NOW;
   edtpmid2.Text:='';
end; //if bfound true


end;

procedure Tfrmpolicemanprofiles.SpeedButton3Click(Sender: TObject);
var
sid:string;
begin
    redoutput.Lines.Clear;

    with datamodule1 do
    begin
      dbgpmpro2.DataSource:=Datamodule1.dsrsql;
      sid:=tblDuties['PolicemanID'];
      qrysql.Close;
      qrysql.SQL.Clear;
      qrysql.SQL.Add('Select * from tblPolicemen where PolicemanID="'+sid+'"');
      qrysql.Open;

      tblPolicemen.First;
      while not tblPolicemen.eof do
      begin
        if tblPolicemen['PolicemanID']=sid then
        begin
          Redoutput.Lines.Add(tblpolicemen['PolicemanName']+' '+tblpolicemen['PolicemanSurname']+' Was On Duty On:');

          tblduties.First;
          while not tblDuties.eof do
          begin
            if tblDuties['PolicemanID']=tblPolicemen['PolicemanID'] then
            begin

            tblBeaches.First;
            while not tblBeaches.eof do
            begin
               if tblDuties['DutyArea']=tblBeaches['BeachID'] then
               begin

              redoutput.Lines.Add(DateToStr(tblduties['DutyDate'])+' at '+tblBeaches['BeachName']);

               end;//if duties=beach

              tblbeaches.Next;

            end;// while not eof beaches

            end; //if duties=policemen
            tblduties.Next;
          end;// while duties

        end; //if = sid
        tblPolicemen.Next;
      end;   //while not eof policemen


    end;//with data mod
end;

end.
