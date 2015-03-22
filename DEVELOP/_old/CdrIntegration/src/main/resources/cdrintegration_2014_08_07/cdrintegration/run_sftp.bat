@echo off
set ROOT_DIR=D:\SimpleSftp
set LIB_DIR=%ROOT_DIR%\lib
set DIST_DIR=%ROOT_DIR%\dist
set CLASSPATH=%LIB_DIR%\camel-core-2.12.3.jar;%LIB_DIR%\camel-ftp-2.12.3.jar;%LIB_DIR%\camel-zipfile-2.12.3.jar;%LIB_DIR%\commons-net-3.3.jar;%LIB_DIR%\jsch-0.1.50.jar;%LIB_DIR%\log4j-1.2.17.jar;%LIB_DIR%\slf4j-api-1.6.6.jar;%LIB_DIR%\slf4j-log4j12-1.7.5.jar;%DIST_DIR%\elcom-simple-ftp-2.12.3.jar;
"C:\Program Files\Java\jdk1.6.0_35\bin\java"  -Xms256m -Xmx256m -cp %CLASSPATH% elcom.simplesftp.MyFtpServer &