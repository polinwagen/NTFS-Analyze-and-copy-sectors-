program kr25;

uses
  Vcl.Forms,
  Unit11 in 'Unit11.pas' {Form11},
  Unit12 in 'Unit12.pas' {Form12},
  ABOUT in 'ABOUT.pas' {AboutBox},
  Unit4 in 'Unit4.pas',
  Unit5 in 'Unit5.pas';

{$R *.res}

 begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm12, Form12);
  Application.Run;
end.
