program XSDJarGenerator;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  RedirectConsole in 'RedirectConsole.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'XSDJar Generator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
