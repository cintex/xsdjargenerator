unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellCtrls, ExtCtrls, FileCtrl,StrUtils,
  Gauges;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    console: TMemo;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Panel2: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Gauge1: TGauge;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
        PathName: string;
  public
    { Public declarations }

     function CreateProcessSimple(sExecutableFilePath : string;Params : String;DefaultDir : string ): string;
     function run(xsdFile:String;outFolder:String): Boolean;
  end;

var
  Form1: TForm1;
  ConsoleOUT: TStrings;

implementation
uses RedirectConsole;
{$R *.dfm}

{ TForm1 }

procedure MyLineOut(s: string); // Output procedure
begin
//  EditForm.memo1.lines.add(s);

  ConsoleOUT.Add(s);


end;

function TForm1.CreateProcessSimple(sExecutableFilePath, Params,
  DefaultDir: string): string;
var
  pi: TProcessInformation;
  si: TStartupInfo;
begin
  FillMemory( @si, sizeof( si ), 0 );
  si.cb := sizeof( si );

  CreateProcess(
//    PCHAR(sExecutableFilePath),
    Nil,
    // path to the executable file:
//    PChar( sExecutableFilePath ),
    PChar( sExecutableFilePath+' '+Params ),
//    Nil,
    Nil,
    Nil,
    False,
    NORMAL_PRIORITY_CLASS,
    Nil,
    PCHAR(DefaultDir),
    si,
     pi );

  // "after calling code" such as
  // the code to wait until the
  // process is done should go here

  CloseHandle( pi.hProcess );
  CloseHandle( pi.hThread );
end;




function TForm1.run(xsdFile:String;outFolder:String): Boolean;
var
RunAPP,mainBatch : String;

begin
  Mainbatch := ExtractFilePath(Application.ExeName);
  
  Console.Lines.Add('>> Ejecución comenzada -> '+ xsdFile +' ... '+ TimeToStr(Now));
  Console.Lines.Add('');
  // parametro1=XSDfile parametro2=outputfolder parametro3=rutaAPP
  execute(ExtractFilePath(Application.ExeName)+'libreria.bat',xsdFile+' '+outFolder+' '+Mainbatch,outFolder);
  Console.Lines.AddStrings(ConsoleOUT);
  Console.Refresh;
  COnsole.Update;

  ConsoleOUT.Clear;
  Console.Lines.Add('');
  Console.Lines.Add('<< Ejecución terminada -> '+ xsdFile +' ... '+ TimeToStr(Now));

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  ConsoleOUT := TStringList.Create;	{ construct the list object }



  lineOut:=MyLineOut; // set Output

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  cleanFilename,temp:String;

begin
  Button1.Caption := 'Procesando....';
  Button1.Enabled:= false;
  Console.Clear;

  Gauge1.MaxValue := FileListBox1.Count;
  for i:=0 to FileListBox1.Count -1 do
  begin
    temp := ExtractFileExt(FileListBox1.Items.ValueFromIndex[i]);
    if (temp='.xsd') then
    begin
      caption := IntToStr(Gauge1.PercentDone)+'% - XSDJar Generator v1.0';
      cleanFilename :=  FileListBox1.Items.Strings[i];
      cleanFilename := AnsiReplaceText(cleanFilename, '.xsd', ' ');
      Label1.Caption := 'Generando libreria: '+cleanFilename+'.jar';

      FileListBox1.Selected[i];

      run(cleanFilename,DirectoryListBox1.Directory);
      Label1.Caption :='compilacion terminada';

    end;

  Gauge1.Progress := i;

  end;

  Button1.Caption := 'Procesar';
  Button1.Enabled:= true;
  Gauge1.Progress :=100;
  caption := IntToStr(Gauge1.PercentDone)+'% - XSDJar Generator v1.0';


end;

end.



