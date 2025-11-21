unit frmcatches_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, jpeg, ExtCtrls, StdCtrls, Grids, DBGrids, Spin, ComCtrls, dmPAT23_u, Validation_U,
  TeEngine, TeeProcs, Chart, Series;

type
  Tfrmcatches = class(TForm)
    pnlbckgd: TPanel;
    pnllogo: TPanel;
    imglogo: TImage;
    imgbckgd: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnldata: TPanel;
    pnlstats: TPanel;
    sbtnstats: TSpeedButton;
    dbgcatch: TDBGrid;
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
    lblcatches: TLabel;
    edtfishsp: TEdit;
    edtpmid: TEdit;
    edtfmid: TEdit;
    edtbeachid: TEdit;
    dtpdoc: TDateTimePicker;
    spnnumfish: TSpinEdit;
    lblfishsp: TLabel;
    lblnumfish: TLabel;
    lbldoc: TLabel;
    lblfmid: TLabel;
    lblpmid: TLabel;
    lblbeachid: TLabel;
    pnlsort: TPanel;
    sbtnsort: TSpeedButton;
    pnlsearching: TPanel;
    sbtnsearching: TSpeedButton;
    pnlstatistics: TPanel;
    chtdanger: TChart;
    dbgcaught: TDBGrid;
    dbgfish2: TDBGrid;
    Panel1: TPanel;
    pnldanger: TPanel;
    btnchtdanger: TSpeedButton;
    chtdiet: TChart;
    pnldietgraph: TPanel;
    btnchtdiet: TSpeedButton;
    pnlqry: TPanel;
    cmbqry: TComboBox;
    chtfish: TChart;
    pnlgraphfish: TPanel;
    btnchtfish: TSpeedButton;
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure sbtnaddClick(Sender: TObject);
    procedure sbtndeleteClick(Sender: TObject);
    procedure sbtnviewClick(Sender: TObject);
    procedure sbtnupdateClick(Sender: TObject);
    procedure sbtnsortClick(Sender: TObject);
    procedure sbtnsearchingClick(Sender: TObject);
    procedure sbtnstatsClick(Sender: TObject);

    procedure btnchtdangerClick(Sender: TObject);
    procedure btnchtdietClick(Sender: TObject);
    procedure btnchtfishClick(Sender: TObject);
    procedure cmbqryChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure searchdiet;
     procedure mostcaught;
     procedure alldanger;
     procedure avgfish;
  end;

var
  frmcatches: Tfrmcatches;
  objval:Tvalidation;

  arrfish: array[1..3]of string;
  arrifish: array[1..3] of integer;

  arrdanger:array[1..2]of string;
  arridanger:array[1..2]of integer;

  arrdiet:array[1..5]of string=('ShellFish','BaitFish','Seaweed','Mollusc','Coral');
  arridiet:array[1..5]of integer;




implementation
   uses frmpolicemanhome_u, frmadminhome_u, frmhelp_u;
{$R *.dfm}

procedure Tfrmcatches.alldanger;
begin
 with datamodule1 do
  begin

  dbgfish2.DataSource:=Datamodule1.dsrsql;
  dbgcaught.DataSource:=datamodule1.dsrcatches;

   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblFish where Endangered=True ');
   qrysql.Open;
  end; //with datamodule
end;

procedure Tfrmcatches.avgfish;   //calcultes and displays the average amount of fish caught everyday
begin
with datamodule1 do
begin
 dbgfish2.DataSource:=Datamodule1.dsrfish;//initializes dbg to display correct information
 dbgcaught.DataSource:=Datamodule1.dsrsql;
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select Avg(FishNo)AS[AverageFish],DateCaught from tblCatches Group By DateCaught');
   qrysql.Open;   //runs sql
end;
end;

procedure Tfrmcatches.cmbqryChange(Sender: TObject);
begin
if cmbqry.Text='All Endangered' then
begin
 alldanger;
end
else
if cmbqry.Text='Display All' then
begin
   dbgcaught.DataSource:=datamodule1.dsrcatches;
   dbgfish2.DataSource:=Datamodule1.dsrfish;
end
else
if cmbqry.Text='Search Diet' then
begin
 searchdiet;
end
else
 if cmbqry.Text='Most Caught' then
begin
 mostcaught;
end
else
if cmbqry.Text='Average Caught' then
begin

   avgfish;
end;


end;

procedure Tfrmcatches.mostcaught;
 var
 sfish,sfmid:string;
 inum,icatch:integer;
begin
    inum:=0;
    sfish:=Inputbox('','Enter Fish Species','');
with datamodule1 do
begin
   tblCatches.First;
   while not tblCatches.eof do
   begin
      if tblCatches['FishSpecies']=sfish then
      begin

        if tblCatches['FishNo']>inum then
        begin
          inum:=tblCatches['FishNo'];
          sfmid:=tblCatches['FishermanID'];
          icatch:=tblCatches['CatchNo'];
        end;


      end; //if=sfish
      tblCatches.Next;
   end;

end;//with datamodule

Showmessage(sfmid+' Caught The Most Amount Of '+sfish+'('+IntToStr(inum)+')'+' (catchno:'+IntToStr(icatch)+')');
end;

/////////////////////////////////////////////
procedure Tfrmcatches.sbtnaddClick(Sender: TObject);
var
sfish,spmid,sfmid,sbid:String;
inumfish:integer;
sdate:string;
bfound:boolean;
begin
 sfish:=edtfishsp.Text;
 inumfish:=spnnumfish.Value;
 sdate:=DateToStr(dtpdoc.Date);
 sdate:=Copy(sdate,1,10);
 sfmid:=edtfmid.Text;
 spmid:=edtpmid.Text;
 sbid:=edtbeachid.Text;
 bfound:=True;

 if (objval.ValidString(sfish)=True)or(objval.CheckEmpty(sfish)=True) then    //valiates data entered
 begin
   showmessage('Enter a valid species name');
   bfound:=False;
 end
 else
 begin

 if objval.Validpkid(sfmid)=false then
 begin
  showmessage('Enter a valid Fisherman ID');
  bfound:=False;
 end
 else
 begin

 if objval.Validpkid(spmid)=false then
 begin
showmessage('Enter a valid Policeman ID');
bfound:=False;
 end
 else
 begin

 if objval.Validpkid(sbid)=false then
 begin
   showmessage('Enter the ID of the beach where the fish were caught');
   bfound:=False;
 end;

 end; // if policeman id valid

 end; //if fisherman id valid


 end; //if sfish valid


   if bfound=true then
   begin

   with datamodule1 do
   begin
     tblCatches.insert;
     tblCatches['FishSpecies']:=sfish;
     tblcatches['FishNo']:=inumfish;
     tblCatches['DateCaught']:= StrToDate(sdate);
     tblCatches['FishermanID']:=sfmid;
     tblCatches['PolicemenID']:=spmid;
     tblCatches['BeachID']:=sbid;
     tblCatches.post;
     tblCatches.Refresh;


   end;  //with datamod
   Showmessage('Catch Added Sucessfully');
    dbgcatch.DataSource:=Datamodule1.dsrcatches;
   edtfishsp.Text:='';
 spnnumfish.Value:=1;
 dtpdoc.Date:=NOW;
 edtfmid.Text:='';
 edtpmid.Text:='';
 edtbeachid.Text:='';

   end; //if bfound


end;
 ////////////////////////////////////////////////////
procedure Tfrmcatches.sbtnbackClick(Sender: TObject); //switches forms
begin
 frmcatches.Hide;
 if frmpolicemanhome.icatches=1 then
 begin
 frmpolicemanhome.Show;
 end
 else
 if frmpolicemanhome.icatches=2 then
 begin
   frmadminhome.show;
 end;


end;

procedure Tfrmcatches.sbtndeleteClick(Sender: TObject);
begin
with datamodule1 do
begin
   tblCatches.Delete;
   tblCatches.Refresh;
   showmessage('Catch Deleted Successfully');
   dbgcatch.DataSource:=Datamodule1.dsrcatches;
end;//with
end;

procedure Tfrmcatches.sbtnhelpClick(Sender: TObject); //shows help form
begin
frmhelp.Show;

if frmpolicemanhome.ifmpro=2 then
begin
 frmhelp.pnlpmhelp.Hide;
 frmhelp.pnlfmhelp.Hide;
 frmhelp.pnladminhelp.Show;
end
else
if frmpolicemanhome.ifmpro=1 then
begin

  frmhelp.pnlfmhelp.Hide;
  frmhelp.pnladminhelp.Hide;
  frmhelp.pnlpmhelp.Show;
end;

end;

procedure Tfrmcatches.sbtnsearchingClick(Sender: TObject);
var
stype:String;
sid:string;
bfound:boolean;
ilength,icount,i:integer;
begin
  bfound:=False;
  if sbtnsearching.Caption='Search' then
  begin
//////////////////////////////////////////////////////////////////////////////
stype:=Inputbox('','Search by FishermenID, PolicemenID Or BeachID?','');
stype:=UPPERCASE(stype);

if (stype='FISHERMANID')OR(stype='FISHERMENID') then
begin
 sid:=Inputbox('','Enter FishermanID','');
  ilength:=Length(sid);

  for i := 1 to ilength do
    begin
      if sid[i]In['a'..'z','A'..'Z'] then
      begin
        inc(icount);
      end; //if in

    end;//for i

 if (ilength<>5)And(icount<>2) then
 begin

   Showmessage('Invalid ID');

 end//if sid valid
 else
 begin

    with datamodule1 do
 begin
   dbgcatch.DataSource:=Datamodule1.dsrsql;
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblCatches where FishermanID like "%'+sid+'%" Order by CatchNo');
   qrysql.Open;
 end;//with data module
 sbtnsearching.Caption:='Display All';

 end;// if sid valid

end //if stype fishermen
else
if (stype='POLICEMANID')or(stype='POLICEMENID')then
begin

 sid:=Inputbox('','Enter PolicemanID','');
  ilength:=Length(sid);
  for i := 1 to ilength do
    begin
      if sid[i]In['a'..'z','A'..'Z'] then
      begin
        inc(icount);
      end; //if in

    end;//for i

 if (ilength=5)And(icount=2) then
 begin
   with datamodule1 do
 begin
   dbgcatch.DataSource:=Datamodule1.dsrsql;
   dbgfish2.DataSource:=Datamodule1.dsrfish;
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblCatches where PolicemenID like "%'+sid+'%" Order by CatchNo');
   qrysql.Open;
 end;//with data module
 sbtnsearching.Caption:='Display All';
 end//if sid valid
 else
 begin
   Showmessage('Invalid ID');
 end;// if sid valid


end // if stype policeman

else
if stype='BEACHID' then
begin

sid:=Inputbox('','Enter BeachID','');
  ilength:=Length(sid);

  for i := 1 to ilength do
    begin
      if sid[i]In['a'..'z','A'..'Z'] then
      begin
        inc(icount);
      end; //if in

    end;//for i

 if (ilength=5)And(icount=2) then
 begin
   with datamodule1 do
 begin
 dbgcatch.DataSource:=Datamodule1.dsrsql;
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblCatches where BeachID like "%'+sid+'%" Order By CatchNo');
   qrysql.Open;
 end;//with data module
 sbtnsearching.Caption:='Display All';
 end//if sid valid
 else
 begin
   Showmessage('Invalid ID');
 end;// if sid valid


end//if stype beachid
else
begin
  Showmessage('Invalid Type Entered');

end;
//////////////////////////////////////////////////////////////////////////////////////

  end//if caption = search
  else
 if sbtnsearching.Caption='Display All' then
  begin
     dbgcatch.DataSource:=Datamodule1.dsrcatches;
     sbtnsearching.Caption:='Search';
  end;
end;

procedure Tfrmcatches.sbtnsortClick(Sender: TObject);
begin
dbgcatch.DataSource:=Datamodule1.dsrcatches;

with datamodule1 do
begin
  tblCatches.Sort:='DateCaught';
end;
end;

procedure Tfrmcatches.sbtnstatsClick(Sender: TObject);
begin
if sbtnstats.Caption='View Stats' then
begin
pnldata.Hide;
pnlstatistics.Show;
 sbtnstats.Caption:='View Catches';
 sbtnstats.Hint:='View Fishermen Catches';
end//if caption= view stats
else
if sbtnstats.Caption='View Catches' then
begin
   pnlstatistics.Hide;
   pnldata.Show;
   sbtnstats.Caption:='View Stats';
   sbtnstats.Hint:='View Catch statistics';
end; //if caption= view catches
end;

procedure Tfrmcatches.sbtnupdateClick(Sender: TObject);
var
sfish,spmid,sfmid,sbid:String;
inumfish:integer;
sdate:string;
bfound:boolean;
begin
 sfish:=edtfishsp.Text;
 inumfish:=spnnumfish.Value;
 sdate:=DateToStr(dtpdoc.Date);
 sdate:=Copy(sdate,1,10);
 sfmid:=edtfmid.Text;
 spmid:=edtpmid.Text;
 sbid:=edtbeachid.Text;
 bfound:=True;

 if (objval.ValidString(sfish)=True)or(objval.CheckEmpty(sfish)=True) then
 begin
   showmessage('Enter a valid species name');
   bfound:=False;
 end
 else
 begin

 if objval.Validpkid(sfmid)=false then
 begin
  showmessage('Enter a valid Fisherman ID');
  bfound:=False;
 end
 else
 begin

 if objval.Validpkid(spmid)=false then
 begin
showmessage('Enter a valid Policeman ID');
bfound:=False;
 end
 else
 begin

 if objval.Validpkid(sbid)=false then
 begin
   showmessage('Enter the ID of the beach where the fish were caught');
   bfound:=False;
 end;

 end; // if policeman id valid

 end; //if fisherman id valid


 end; //if sfish valid


   if bfound=true then
   begin

   with datamodule1 do
   begin
     tblCatches.edit;
     tblCatches['FishSpecies']:=sfish;
     tblcatches['FishNo']:=inumfish;
     tblCatches['DateCaught']:= StrToDate(sdate);
     tblCatches['FishermanID']:=sfmid;
     tblCatches['PolicemenID']:=spmid;
     tblCatches['BeachID']:=sbid;
     tblCatches.post;
     tblCatches.Refresh;


   end;  //with datamod
   Showmessage('Catch Edited Sucessfully');
   dbgcatch.DataSource:=Datamodule1.dsrcatches;
   edtfishsp.Text:='';
 spnnumfish.Value:=1;
 dtpdoc.Date:=NOW;
 edtfmid.Text:='';
 edtpmid.Text:='';
 edtbeachid.Text:='';

   end; //if bfound


end;

procedure Tfrmcatches.sbtnviewClick(Sender: TObject);
begin
with datamodule1 do
begin
 edtfishsp.Text:=tblCatches['FishSpecies'];    //puts data into componenet  from table
 spnnumfish.Value:=tblCatches['FishNo'];
 dtpdoc.Date:=tblCatches['DateCaught'];
 edtfmid.Text:=tblCatches['FishermanID'];
 edtpmid.Text:=tblCatches['PolicemenID'];
 edtbeachid.Text:=tblCatches['BeachID'];
end; //with datamodule
end;



procedure Tfrmcatches.searchdiet;
var
sdiet:string;
begin
 sdiet:=Inputbox('','Enter Diet','');   //searches for the diet

 with datamodule1 do
 begin
     dbgfish2.DataSource:=Datamodule1.dsrsql;
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblFish where Diet like "%'+sdiet+'%" ');
   qrysql.Open;
 end; //with datamodule1
end;

procedure Tfrmcatches.btnchtdangerClick(Sender: TObject); //generates a graph to display the number of endangered species
var
i,idanger,inotdanger:integer;
Bar:TBarSeries;
begin

 idanger:=0;
 inotdanger:=0;
with datamodule1 do
begin

tblFish.First;
while not tblFish.eof do
begin

if tblFish['Endangered']=True then
begin
inc(idanger);
end
else
begin
  inc(inotdanger);
end;

  tblfish.Next;
end;  //while now end of tblfish

end;// with data module


arridanger[1]:=idanger;
arrdanger[1]:='Endangered';
arridanger[2]:=inotdanger;
arrdanger[2]:='Not Endangered';



Bar:=TBarseries.Create(Self);  //generates bar graph
for i := 1 to 2 do
  begin
    bar.Addbar(arridanger[i],arrdanger[i],random($ffffff));
    bar.ParentChart:=chtdanger;
  end;

end;

procedure Tfrmcatches.btnchtdietClick(Sender: TObject);
var
slocation:string;
 i:integer;
 pie:TpieSeries;
begin
 slocation:=Inputbox('','Enter Location To Analyse','');

 for i := 1 to 5 do
   begin
     arridiet[i]:=0;
   end;

with datamodule1 do
begin
     tblFish.First;
     while not tblFish.eof do
     begin
        if tblFish['MainLocation']=slocation then
           begin


           if tblFish['Diet']='ShellFish' then  //populates arrays
           begin
             arridiet[1]:=arridiet[1]+1
           end
           else
           if tblFish['Diet']='BaitFish' then
           begin
             arridiet[2]:=arridiet[2]+1;
           end
           else
           if tblFish['Diet']='Seaweed' then
           begin
             arridiet[3]:=arridiet[3]+1;
           end
           else
           if tblFish['Diet']='Mollusc' then
           begin
              arridiet[4]:=arridiet[4]+1;
           end
           else
           if tblFish['Diet']='Coral' then
           begin
              arridiet[5]:=arridiet[5]+1;
           end;
           end;//if location =

        tblFish.Next;
     end; // while not eof

end;// with datamod

 pie:=Tpieseries.Create(Self);//generates pie chart
for i := 1 to 5 do
  begin
    pie.Addpie(arridiet[i],arrdiet[i],random($ffffff));
    pie.ParentChart:=chtdiet;
  end;



end;

procedure Tfrmcatches.btnchtfishClick(Sender: TObject);
var
sfish1,sfish2,sfish3:string;
i:integer;
bar:TBarSeries;
begin
sfish1:=Inputbox('','Enter First Fish Species','');   //gains all the species to analyse
sfish2:=Inputbox('','Enter Second Fish Species','');
sfish3:=Inputbox('','Enter Third Fish Species','');

arrfish[1]:=sfish1;    //populates arrays
arrfish[2]:=sfish2;
arrfish[3]:=sfish3;


for i := 1 to 3 do //initializes the fish array
  begin
     arrifish[i]:=0;
  end;  //for i 1..3

with datamodule1 do
begin
  tblCatches.First;

  while not tblcatches.Eof  do
  begin

  if tblCatches['FishSpecies']=sfish1 then   //populates arrays
  begin
    arrifish[1]:=arrifish[1]+tblCatches['FishNo'];
  end
  else
    if tblCatches['FishSpecies']=sfish2 then
  begin
    arrifish[2]:=arrifish[2]+tblCatches['FishNo'];
  end
  else
  if tblCatches['FishSpecies']=sfish3 then
  begin
    arrifish[3]:=arrifish[3]+tblCatches['FishNo'];
  end;
    tblCatches.Next;
  end; //while not eof
end;//with datamodule

Bar:=TBarseries.Create(Self);   //generates bar graph
for i := 1 to 3 do
  begin
    bar.Addbar(arrifish[i],arrfish[i],random($ffffff));
    bar.ParentChart:=chtfish;
  end;

end;

end.
