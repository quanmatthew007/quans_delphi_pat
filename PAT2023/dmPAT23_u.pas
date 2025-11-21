unit dmPAT23_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    tblFish: TADOTable;
    dsrfish: TDataSource;
    tblFishermen: TADOTable;
    dsrfishermen: TDataSource;
    qrysql: TADOQuery;
    dsrsql: TDataSource;
    tblBeaches: TADOTable;
    dsrbeaches: TDataSource;
    tblPolicemen: TADOTable;
    dsrpolicemen: TDataSource;
    tblDuties: TADOTable;
    dsrduties: TDataSource;
    tblCatches: TADOTable;
    dsrcatches: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
