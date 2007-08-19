@echo off

rd javaclass /s/q
rd javasrc /s/q
REM param1= xsdFile param2=outputdirectory param3=appPath
set PATH= %3;%3xmlbeans\lib\;%3xmlbeans\bin\;%3xmlbeans\lib\xbean.jar;%3xmlbeans\lib\;%3xmlbeans\lib\jsr173_1.0_api.jar;%PATH%

@echo off

scomp -d javaclass/%1 -src javasrc/%1 -out %1.jar -ms 64m -mx 256m -compiler "C:\Archivos de programa\Java\jdk1.6.0_01\bin\javac" -javasource 1.4 %1.xsd %1.xsdconfig