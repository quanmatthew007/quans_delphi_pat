unit frmfishermanprofiles_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, jpeg, Spin, StdCtrls, Grids, DBGrids, dmPAT23_u, Validation_u;

type
  Tfrmfishermanprofiles = class(TForm)
    pnlbckgd: TPanel;
    pnllogo: TPanel;
    imglogo: TImage;
    imgbckgd: TImage;
    pnlhelp: TPanel;
    sbtnhelp: TSpeedButton;
    pnlback: TPanel;
    sbtnback: TSpeedButton;
    pnldata: TPanel;
    lbltitle: TLabel;
    dbgfishermen: TDBGrid;
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
    edtfmid: TEdit;
    edtfmname: TEdit;
    edtfmsurname: TEdit;
    edtcontactno: TEdit;
    spnfmage: TSpinEdit;
    lblfmid: TLabel;
    lblfmname: TLabel;
    lblfmsurname: TLabel;
    lblfmcontactno: TLabel;
    lblfmage: TLabel;
    pnlsort: TPanel;
    sbtnsort: TSpeedButton;
    pnlsearching: TPanel;
    sbtnsearching: TSpeedButton;
    procedure sbtnbackClick(Sender: TObject);
    procedure sbtnhelpClick(Sender: TObject);
    procedure sbtnaddClick(Sender: TObject);
    procedure sbtndeleteClick(Sender: TObject);
    procedure sbtnviewClick(Sender: TObject);
    procedure sbtnupdateClick(Sender: TObject);
    procedure sbtnsortClick(Sender: TObject);
    procedure sbtnsearchingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmfishermanprofiles: Tfrmfishermanprofiles;
   objval:Tvalidation;
implementation
   uses frmpolicemanhome_u, frmadminhome_u, frmhelp_u;
{$R *.dfm}





procedure Tfrmfishermanprofiles.sbtnaddClick(Sender: TObject);
var
sid,sname,ssurname,scon:string;
iage,i,ilength,icount:integer;
bfound:boolean;
begin

 bfound:=true;
 sid:=edtfmid.Text;    //extracts data from components
 sname:=edtfmname.Text;
 ssurname:=edtfmsurname.Text;
 scon:=edtcontactno.Text;
 iage:=spnfmage.Value;

 ilength:=length(sid);
  for i :=1 to ilength do
  begin
    if sid[i] IN ['A' .. 'Z', 'a' .. 'z']then
    begin
      inc(icount);
    end;//if in

  end;//for loop

   if (ilength=5) and (icount=2) then    //validates entered details
   begin

   if (objval.ValidString(sname)=true) OR(objval.CheckEmpty(sname)=true) then
   begin
     showmessage('Invalid Name');
     bfound:=False;
   end
   else
   begin

    if (objval.ValidString(ssurname)=true) OR(objval.CheckEmpty(ssurname)=true) then
   begin
     showmessage('Invalid Surname');
     bfound:=False;
   end
   else
   begin

    if objval.ValidContact(scon)=true then
    begin
      bfound:=False;
      showmessage('Invalid contact number');
    end
    else
    begin

    if iage<13 then
    begin
      showmessage('Fishermen Cannot Be Younger Than 13.');
      bfound:=False;
    end; //if age valid

    end; //if contact valid

   end; //if surname valid


   end;//if name valid


   end //if id valid
   else
   begin
    showmessage('Fisherman ID must be made up of 3 letters and 2 numbers');
    bfound:=False;
   end;


   if bfound=True then
   begin
     with datamodule1 do
     begin
        tblFishermen.Insert;
        tblFishermen['FishermanID']:= sid;  //enters details into database
        tblFishermen['FishermanName']:= sname;
        tblFishermen['FishermanSurname']:=ssurname;
        tblFishermen['FmContactNo']:=  scon;
        tblFishermen['Fmage']:=iage;
        tblFishermen.Post;
        tblFishermen.Refresh;

     end;//with datamod
     showmessage('Fisherman Successfully Added');
     dbgfishermen.DataSource:=DataModule1.dsrfishermen;

     edtfmid.Text:=''; //initializes components for next execution
     edtfmname.Text:='';
     edtfmsurname.Text:='';
     edtcontactno.Text:='';
     spnfmage.Value:=1;
     sbtnsearching.Caption:='Search';
   end;//if bfound true, execute insertion




end;






procedure Tfrmfishermanprofiles.sbtnbackClick(Sender: TObject);   //goes back to previous form
begin
  frmfishermanprofiles.Hide;               //changes between forms
  if frmpolicemanhome.ifmpro=1 then
  begin
  frmpolicemanhome.show;
  end
  else
  if frmpolicemanhome.ifmpro=2 then

  begin
   frmadminhome.Show;
  end;
end;

procedure Tfrmfishermanprofiles.sbtndeleteClick(Sender: TObject);
begin

with datamodule1 do
begin
tblFishermen.Delete;
tblFishermen.Refresh;
showmessage('Profile Successfully Removed');
end;// with datamod
sbtnsearching.Caption:='Search';
dbgfishermen.DataSource:=DataModule1.dsrfishermen;
end;

procedure Tfrmfishermanprofiles.sbtnhelpClick(Sender: TObject);
begin
   frmhelp.Show;
  if frmpolicemanhome.ifmpro=1 then
  begin
  frmhelp.pnladminhelp.Hide;   //shows help and initializes components
  frmhelp.pnlfmhelp.Hide;
  frmhelp.pnlpmhelp.Show;
  end
  else
  if frmpolicemanhome.ifmpro=2 then
  begin
  frmhelp.pnlpmhelp.Hide;
  frmhelp.pnlfmhelp.Hide;
  frmhelp.pnladminhelp.Show;
  end;
end;

procedure Tfrmfishermanprofiles.sbtnsearchingClick(Sender: TObject);
var
sname:string;
begin
if sbtnsearching.Caption='Search' then //searches for detailsin database
begin


//////////////////////////////////////
  sname:=Inputbox('','Enter Name Of Fisherman','');


 with datamodule1 do
 begin
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblFishermen where FishermanName like "%'+sname+'%" ');
   qrysql.Open;
 end;
 dbgfishermen.DataSource:=DataModule1.dsrsql;
  sbtnsearching.Caption:='Display All';
//////////////////////////////////////


end//if caption search
else
if sbtnsearching.Caption='Display All' then
begin
 //////////////////////////////////////


 with datamodule1 do
 begin
   qrysql.Close;
   qrysql.SQL.Clear;
   qrysql.SQL.Add('Select * from tblFishermen');
   qrysql.Open;
 end;
 dbgfishermen.DataSource:=DataModule1.dsrsql;
  sbtnsearching.Caption:='Search';
     edtfmid.Text:=''; //initializes components for next execution
     edtfmname.Text:='';
     edtfmsurname.Text:='';
     edtcontactno.Text:='';
     spnfmage.Value:=1;
//////////////////////////////////////
end; //if caption Display All

end;

procedure Tfrmfishermanprofiles.sbtnsortClick(Sender: TObject);
begin
dbgfishermen.DataSource:=DataModule1.dsrfishermen;
with datamodule1 do
begin
  tblFishermen.Sort:='FishermanName';    //sorts data
end;
end;

procedure Tfrmfishermanprofiles.sbtnupdateClick(Sender: TObject);
var
sid,sname,ssurname,scon:string;
iage,i,ilength,icount:integer;
bfound:boolean;
begin

 bfound:=true;
 sid:=edtfmid.Text;    //extracts data from components
 sname:=edtfmname.Text;
 ssurname:=edtfmsurname.Text;
 scon:=edtcontactno.Text;
 iage:=spnfmage.Value;

 ilength:=length(sid);
  for i :=1 to ilength do
  begin
    if sid[i] IN ['A' .. 'Z', 'a' .. 'z']then
    begin
      inc(icount);
    end;//if in

  end;//for loop

   if (ilength=5) and (icount=2) then
   begin

   if (objval.ValidString(sname)=true) OR(objval.CheckEmpty(sname)=true) then
   begin
     showmessage('Invalid Name');              //validates entered data
     bfound:=False;
   end
   else
   begin

    if (objval.ValidString(ssurname)=true) OR(objval.CheckEmpty(ssurname)=true) then
   begin
     showmessage('Invalid Surname');
     bfound:=False;
   end
   else
   begin

    if objval.ValidContact(scon)=true then
    begin
      bfound:=False;
      showmessage('Invalid contact number');
    end
    else
    begin

    if iage<13 then
    begin
      showmessage('Fishermen Cannot Be Younger Than 13.');
      bfound:=False;
    end; //if age valid

    end; //if contact valid

   end; //if surname valid


   end;//if name valid


   end //if id valid
   else
   begin
    showmessage('Fisherman ID must be made up of 3 letters and 2 numbers');
    bfound:=False;
   end;

   if bfound=True then
   begin
     with datamodule1 do
     begin
        tblFishermen.Edit;
        tblFishermen['FishermanID']:= sid;    //inserts edited data into database
        tblFishermen['FishermanName']:= sname;
        tblFishermen['FishermanSurname']:=ssurname;
        tblFishermen['FmContactNo']:=  scon;
        tblFishermen['Fmage']:=iage;
        tblFishermen.Post;
        tblFishermen.Refresh;
     end;//with datamod
     showmessage('Fisherman Successfully Updated');

     edtfmid.Text:=''; //initializes components for next execution
     edtfmname.Text:='';
     edtfmsurname.Text:='';
     edtcontactno.Text:='';
     spnfmage.Value:=1;
   end;//if bfound true, execute insertion




end;


procedure Tfrmfishermanprofiles.sbtnviewClick(Sender: TObject);
begin

with datamodule1 do
begin
     edtfmid.Text:=tblFishermen['FishermanID'];
     edtfmname.Text:=tblFishermen['FishermanName'];
     edtfmsurname.Text:=tblFishermen['FishermanSurname'];
     edtcontactno.Text:=tblFishermen['FmContactNo'];
     spnfmage.Value:=tblFishermen['fmage'];
end;//with datamod

if sbtnsearching.Caption='Display All' then
begin
dbgfishermen.DataSource:=DataModule1.dsrsql;       //initializes components
end
else
begin
dbgfishermen.DataSource:=DataModule1.dsrfishermen;
end;
end;

end.
