unit clspmlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons, Spin, ComCtrls;

    type
  tpmlogin=class(Tobject)
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
          uses frmlogin_u, frmpolicemanhome_u;
{ tfmlogin }

constructor tpmlogin.Create(suname, spword: String);
begin
funame:=suname;
fpword:=spword;
fvalid:=False;
end;

function tpmlogin.getpword: string;
begin
  result:=fpword;
end;

function tpmlogin.getuname: String;
begin
  result:=funame;
end;

procedure tpmlogin.move;
begin
if fvalid=true then
begin
 frmlogin.hide;
 frmpolicemanhome.show;
end
else
begin
  frmlogin.edtpmusername.Color:=Clred;
  frmlogin.edtpmpassword.Color:=Clred;
end;
end;

procedure tpmlogin.setvalid;

 var
sline,stuname,stpword:string;
tfile:textfile;
ipos:integer;
begin
 if fileexists('policemanlogin.txt') then//checks if file is present
begin
  assignfile(tfile,'policemanlogin.txt'); //makes a copy in delphi
  reset(tfile); //brings cursor to the top
  while not Eof(tfile) do
  begin
    readln(tfile,sline); //copys a single line from textfile
    ipos:=pos('!',sline);//gets position of the # in sline
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


function tpmlogin.tostring: string;
begin
  if fvalid=true then
  begin
    result:='Login Successful, Welcome Policeman!';
  end
  else
  begin
    result:='The Entered details are invalid or do not exist';
  end;
end;

end.
