unit clsfmlogin;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons, Spin, ComCtrls;

  type
  tfmlogin=class(Tobject)
    private
    funame:String;
    fpword:string;
    fvalid:boolean;

    public

    Constructor Create(suname,spword:String);
    Function getuname:String;
    Function getpword:string;
    Procedure setvalid;
    procedure move;
    Function tostring:string;

  end;

implementation
   uses frmlogin_u, frmfishermanhome_u;
{ tfmlogin }

constructor tfmlogin.Create(suname, spword: String);
begin
funame:=suname;
fpword:=spword;
fvalid:=False;
end;

function tfmlogin.getpword: string;
begin
  result:=fpword;
end;

function tfmlogin.getuname: String;
begin
  result:=funame;
end;

procedure tfmlogin.move;
begin
if fvalid=true then
begin
  frmlogin.hide;
  frmfishermanhome.show;
end
else
begin
  frmlogin.edtfmusername.Color:=Clred;
  frmlogin.edtfmpassword.Color:=Clred;
end;
end;

procedure tfmlogin.setvalid;
var
sline,stuname,stpword:string;
tfile:textfile;
ipos:integer;
begin
 if fileexists('fishermanlogin.txt') then //checks if file is present
begin
  assignfile(tfile,'fishermanlogin.txt');//makes a copy in delphi
  reset(tfile);
  while not Eof(tfile) do
  begin
    readln(tfile,sline);
    ipos:=pos('!',sline);
    stuname:=copy(sline,1,ipos-1);//takes out username from sline
    stpword:=copy(sline,ipos+1);//takes out password from sline
     if (stuname=getuname) And (stpword=getpword) then
    begin
    fvalid:=True;
    end;
  end;
  close(tfile);
end
else
begin
  showmessage('The File Does Not Exist');
end;
end;

function tfmlogin.tostring: string;
begin
  if fvalid=true then
  begin
    result:='Login Successful, Welcome Fisherman!';
  end
  else
  begin
    result:='The Entered details are invalid or do not exist';
  end;
end;

end.
