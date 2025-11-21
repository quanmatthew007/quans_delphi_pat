program pat23_p;

uses
  Forms,
  pat23_u in 'pat23_u.pas' {frmwelcome},
  frmlogin_u in 'frmlogin_u.pas' {frmlogin},
  frmfishermanhome_u in 'frmfishermanhome_u.pas' {frmfishermanhome},
  frmpolicemanhome_u in 'frmpolicemanhome_u.pas' {frmpolicemanhome},
  frmadminhome_u in 'frmadminhome_u.pas' {frmadminhome},
  frmfishinfo_u in 'frmfishinfo_u.pas' {frmfishinfo},
  frmbeachinfo_u in 'frmbeachinfo_u.pas' {frmbeachinfo},
  frmfishermanprofiles_u in 'frmfishermanprofiles_u.pas' {frmfishermanprofiles},
  frmcatches_u in 'frmcatches_u.pas' {frmcatches},
  frmbackground_u in 'frmbackground_u.pas' {frmbackground},
  frmload_u in 'frmload_u.pas' {frmload},
  clsfmlogin in 'clsfmlogin.pas',
  clspmlogin in 'clspmlogin.pas',
  frmpolicemanprofiles_u in 'frmpolicemanprofiles_u.pas' {frmpolicemanprofiles},
  frmhelp_u in 'frmhelp_u.pas' {frmhelp},
  dmPAT23_u in 'dmPAT23_u.pas' {DataModule1: TDataModule},
  Validation_U in 'Validation_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrmbackground, frmbackground);
  Application.CreateForm(Tfrmadminhome, frmadminhome);
  Application.CreateForm(Tfrmcatches, frmcatches);
  Application.CreateForm(Tfrmbeachinfo, frmbeachinfo);
  Application.CreateForm(Tfrmhelp, frmhelp);
  Application.CreateForm(Tfrmfishermanhome, frmfishermanhome);
  Application.CreateForm(Tfrmwelcome, frmwelcome);
  Application.CreateForm(Tfrmpolicemanhome, frmpolicemanhome);
  Application.CreateForm(Tfrmfishinfo, frmfishinfo);
  Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(Tfrmfishermanprofiles, frmfishermanprofiles);
  Application.CreateForm(Tfrmload, frmload);
  Application.CreateForm(Tfrmpolicemanprofiles, frmpolicemanprofiles);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
