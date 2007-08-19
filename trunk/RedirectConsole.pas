unit RedirectConsole;


interface
//uses AdvMemo;

const
  CRLF=#13#10;

var
  SendBuf: string;
  rcEnd: Boolean;
  ExitCode: Cardinal;


procedure execute(sExecutableFilePath: string;Params : String ;DefaultDir : string);
procedure lineIn(s: string);
//var       RC_LineOut: procedure(s: string);
var       lineOut: procedure(s: string);

implementation

uses Windows,Forms;

procedure lineIn(s: string);
begin
  SendBuf:=SendBuf+s+CRLF;
end; //LineIn;

function IsWinNT: Boolean;
var osv: tOSVERSIONINFO;
begin
  osv.dwOSVersionInfoSize:=sizeof(osv);
  GetVersionEx(osv);
  result:=osv.dwPlatformID=VER_PLATFORM_WIN32_NT;
end; // IsWinNT

procedure SplitLines(s: string);
var t: string;
begin
  while pos(CRLF, s)<>0 do begin
    t:=copy(s, 1, pos(CRLF, s)-1);
    lineOut(t);
    delete(s, 1, pos(CRLF, s)+1);
  end;
  if length(s)>0 then
  lineOut(s);

end; // SplitLines


procedure execute(sExecutableFilePath: string;Params : String ;DefaultDir : string);
const bufsize=1024; // 1KByte buffer
var
  buf: array [0..bufsize-1] of char;
  si: tSTARTUPINFO;
  sa: tSECURITYATTRIBUTES;
  sd: tSECURITYDESCRIPTOR;
  pi: tPROCESSINFORMATION;
  newstdin, newstdout, read_stdout, write_stdin: tHandle;
  bread, avail: dword;
begin
  // Configuraciones de seguridad para WinNT
  if IsWinNT then begin
    InitializeSecurityDescriptor(@sd, SECURITY_DESCRIPTOR_REVISION);
    SetSecurityDescriptorDacl(@sd, true, nil, false);
    sa.lpSecurityDescriptor:=@sd;
  end else sa.lpSecurityDescriptor:=nil;
  // Creamos Pipe A
  if not CreatePipe(newstdin, write_stdin, @sa, 0) then begin
    lineOut('Error creating Pipe A');

    exit;
  end;
  // Creamos Pipe B
  if not CreatePipe(read_stdout, newstdout, @sa, 0) then begin
    lineOut('Error creating Pipe B');

    CloseHandle(newstdin);
    CloseHandle(write_stdin);
    exit;
  end;
  // Configuramos si
  GetStartupInfo(si);
  si.dwFlags:=STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  si.wShowWindow:=SW_HIDE;
  si.hStdOutput:=newstdout;
  si.hStdError:=newstdout;
  si.hStdInput:=newstdin;
  // Creamos proceso
  {

    if not CreateProcess(pchar(command), nil, nil, nil, true,
    CREATE_NEW_CONSOLE, nil, nil, si, pi) then begin
    RC_LineOut('Error creating process: '+command);
    CloseHandle(newstdin);
    CloseHandle(newstdout);
    CloseHandle(read_stdout);
    CloseHandle(write_stdin);
    exit;

  }

  {
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
  }
  if not CreateProcess(
  nil,
  PChar( sExecutableFilePath+' '+Params ),
  nil,
  nil,
  true,
  CREATE_NEW_CONSOLE,
  nil,
  PCHAR(DefaultDir),
  si,
  pi) then begin
    lineOut('Error creating process: '+sExecutableFilePath);

    CloseHandle(newstdin);
    CloseHandle(newstdout);
    CloseHandle(read_stdout);
    CloseHandle(write_stdin);
    exit;
  end;
  // Loop principal
  fillchar(buf, sizeof(buf), 0);
  rcEnd:=false;
  SendBuf:='';
  repeat
     application.processmessages;
//    Application.HandleMessage;
    GetExitCodeProcess(pi.hProcess, ExitCode);
    if (ExitCode<>STILL_ACTIVE) then rcEnd:=True;
    PeekNamedPipe(read_stdout, @buf, bufsize, @bread, @avail, nil);
    // Comprobamos texto de salida
    if (bread<>0) then begin
      fillchar(buf, bufsize, 0);
      if (avail>bufsize) then
        while (bread>=bufsize) do begin
          ReadFile(read_stdout, buf, bufsize, bread, nil);
          SplitLines(buf);
          fillchar(buf, bufsize, 0);
        end
      else begin
        ReadFile(read_stdout, buf, bufsize, bread, nil);
        SplitLines(buf);
      end;
    end;
    // Comprobamos texto de entrada
    while (Length(SendBuf)>0) do begin
      WriteFile(write_stdin, SendBuf[1], 1, bread, nil);
      Delete(SendBuf, 1, 1);
    end;
  until rcEnd;
  // Cerramos las cosas
  CloseHandle(pi.hThread);
  CloseHandle(pi.hProcess);
  CloseHandle(newstdin);
  CloseHandle(newstdout);
  CloseHandle(read_stdout);
  CloseHandle(write_stdin);
end; 

end.
