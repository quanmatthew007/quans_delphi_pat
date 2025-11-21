object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 598
  Width = 701
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Us' +
      'ers\2022\Desktop\PAT 2023 PHASE 2-Final\dbfinder.mdb;Mode=ReadWr' +
      'ite;Persist Security Info=False;Jet OLEDB:System database="";Jet' +
      ' OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB' +
      ':Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Globa' +
      'l Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OL' +
      'EDB:New Database Password="";Jet OLEDB:Create System Database=Fa' +
      'lse;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale' +
      ' on Compact=False;Jet OLEDB:Compact Without Replica Repair=False' +
      ';Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 48
    Top = 40
  end
  object tblFish: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblFish'
    Left = 184
    Top = 40
  end
  object dsrfish: TDataSource
    DataSet = tblFish
    Left = 280
    Top = 40
  end
  object tblFishermen: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblFishermen'
    Left = 184
    Top = 128
  end
  object dsrfishermen: TDataSource
    DataSet = tblFishermen
    Left = 280
    Top = 128
  end
  object qrysql: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 488
    Top = 56
  end
  object dsrsql: TDataSource
    DataSet = qrysql
    Left = 568
    Top = 56
  end
  object tblBeaches: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblBeaches'
    Left = 184
    Top = 208
  end
  object dsrbeaches: TDataSource
    DataSet = tblBeaches
    Left = 280
    Top = 208
  end
  object tblPolicemen: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblPolicemen'
    Left = 184
    Top = 304
  end
  object dsrpolicemen: TDataSource
    DataSet = tblPolicemen
    Left = 280
    Top = 296
  end
  object tblDuties: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblDuties'
    Left = 184
    Top = 376
  end
  object dsrduties: TDataSource
    DataSet = tblDuties
    Left = 280
    Top = 376
  end
  object tblCatches: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblCatches'
    Left = 184
    Top = 448
  end
  object dsrcatches: TDataSource
    DataSet = tblCatches
    Left = 280
    Top = 448
  end
end
