unit Validation_U;

interface

USES SysUtils,  DBGrids, DB, ADODB, DateUtils;

TYPE
  Tvalidation = class(Tobject)
  Private

  public
    function ValidString(sValue: String): boolean;
    function CheckEmpty(sCheckValue: string): boolean;
    function ValidContact(sNum: String): boolean;
    function ValidID(sID: string): boolean;
    function ValidNumber(sNumber: string): boolean;
    function ValidEmail(sEmail: string): boolean;
    function ValidReal(sNum: string): boolean;
    function Validpkid(sid:string):boolean;
  end;

implementation

{ Tvalidation }

function Tvalidation.CheckEmpty(sCheckValue: string): boolean;
begin
  CheckEmpty := false;
  if (sCheckValue = '') then
    CheckEmpty := true;
end;

function Tvalidation.ValidContact(sNum: String): boolean;
var
  iC, iNum: Integer;
  sPart: string;
begin
  Result := False;
  if NOT(length(sNum) = 10) then
    Result := True;
  for iC := 1 to length(sNum) do
  begin
    sPart := copy(sNum, iC, 1);
    if NOT(TryStrToInt(sPart, iNum)) then
      Result := True;
  end; // for
end;

function Tvalidation.ValidEmail(sEmail: string): boolean;
const
  charslist = ['_', '-', '.', '0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
var
  Arobasc, lastpoint, bValid: boolean;
  i, n: Integer;
  c: char;
begin
  n := length(sEmail); // Length of the email
  i := 1;
  Arobasc := false;
  lastpoint := false;
  bValid := true;
  while (i <= n) do // while counter is less than the length of the email
  begin
    c := sEmail[i];
    if c = '@' then // checks if Position in email is an @
    begin
      if Arobasc then // Only 1 Arobasc
      begin
        bValid := false;
        exit;
      end;
      Arobasc := true;
    end
    else if (c = '.') and Arobasc then // at least 1 . after arobasc
    begin
      lastpoint := true;
    end
    else if not(c in charslist) then // valid chars
    begin
      bValid := false;
      exit;
    end;
    inc(i);
  end;
  if not(lastpoint) or (sEmail[n] = '.') then // not finish by . and have a . after arobasc
    bValid := false;
  Result := bValid;
end;

function Tvalidation.ValidID(sID: string): boolean;
var
  iC, iNum, iSum1, iSum2, iSum3, iSum4, iControl, iLength, iCheck: Integer;
  sPart, sDate, sSum2, sTotalD: string;
  dDate: TDateTime;
begin
  Result := true;
  if NOT(length(sID) = 13) then
  begin
    Result := false;
  end;
  for iC := 1 to length(sID) do
  begin
    sPart := copy(sID, iC, 1);
    if NOT(TryStrToInt(sPart, iNum)) then
    begin
      Result := false;
    end;
  end; // for

  if Result = true then
  begin
    if StrToInt('20' + copy(sID, 1, 2)) > (YearOf(Date)) then
    // checking if born in 1900
    begin
      sDate := '19' + copy(sID, 1, 2) + '/' + copy(sID, 3, 2) + '/' + copy(sID,
        5, 2); // compiling date
    end
    else
    begin
      sDate := '20' + copy(sID, 1, 2) + '/' + copy(sID, 3, 2) + '/' + copy(sID,
        5, 2); // if born in 2000
    end;
    if NOT(TryStrToDate(sDate, dDate)) then
    begin
      Result := false;
    end;
  end; // if

  if Result = true then
  begin
    iSum1 := 0;
    sSum2 := '';
    for iC := 1 to 12 do
    begin
      if (iC mod 2 = 1) then
        iSum1 := iSum1 + StrToInt(sID[iC]) // sum1 - adding odd numbers
      else
        sSum2 := sSum2 + sID[iC]; // joining even numbers as a string
    end; // for

    iSum2 := StrToInt(sSum2) * 2; // multiplying even string number by 2
    iSum3 := 0;
    sTotalD := IntToStr(iSum2);
    for iC := 1 to length((sTotalD)) do // sum of the digits (of even string number *2)
    begin
      iSum3 := iSum3 + StrToInt(sTotalD[iC]);
    end;

    iSum4 := iSum3 + iSum1;
    iControl := 10 - (iSum4 mod 10);
    iCheck := StrToInt(sID[length(sID)]);
    if (iControl > 9) Then
    begin
      if (iControl mod 10) <> (iCheck) then // checking if last digit is equal to check digit
        Result := false;
    end
    else if (iControl <> iCheck) then
    begin
      Result := false;
    end; // if
  end; // if
end;

function Tvalidation.ValidNumber(sNumber: string): boolean;
var
  iC: Integer;
begin
  Result := false;
  for iC := 1 to length(sNumber) do
  begin
    if NOT(sNumber[iC] in ['0' .. '9']) then
      Result := true;
  end;
end;

function Tvalidation.Validpkid(sid: string): boolean;
var
icount,i,ilength:integer;
begin
icount:=0;
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

if (ilength=5) and (icount=2)then
begin
  Result:=True;
end
else
begin
  Result:=False;
end;

end;

function Tvalidation.ValidReal(sNum: string): boolean;
var
  iC: Integer;
  bValid: boolean;
begin
  bValid := false;
  for iC := 1 to (length(sNum)) do
  begin
    if NOT(sNum[iC] in ['0' .. '9', ',']) then
    begin
      bValid := true;
    end;
  end;
  Result:=bValid;
end;

function Tvalidation.ValidString(sValue: String): boolean;
var
  iC: Integer;
begin
  Result := false;
  sValue := UpperCase(sValue);
  for iC := 1 to length(sValue) do
  begin
    if NOT(sValue[iC] in ['A' .. 'Z', ' ']) then
      Result := true;
  end;
end;

end.
