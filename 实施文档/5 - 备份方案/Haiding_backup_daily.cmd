@echo off

e:
cd \backup\script

writefile file=temp1.cmd content="set backup_param1=##now-1##" dateformat="YYYY-MM-DD" append=false
call temp1.cmd
del temp1.cmd

writefile file=temp1.cmd content="set backup_param2=##now-1##" dateformat="YYMMDD" append=false
call temp1.cmd
del temp1.cmd

writefile file=temp1.cmd content="set backup_param3=##now-1##" dateformat="YYYYMMDD" append=false
call temp1.cmd
del temp1.cmd

e:
md \backup\%backup_param1%
cd \backup\%backup_param1%

rem 数据库
exp $$数据库用户名$$/$$数据库密码$$@$$数据库服务名$$ file=Haiding_%backup_param1%_DB.dat full=y log=Haiding_%backup_param1%_DB_ExpLog.txt
type *.txt >> Haiding_%backup_param1%_Backuplog.log
del *.txt /q >> Haiding_%backup_param1%_Backuplog.log
rar a -r Haiding_%backup_param1%_DB.rar *.dat >> Haiding_%backup_param1%_Backuplog.log
del *.dat /q >> Haiding_%backup_param1%_Backuplog.log

rem WEB文件
rar a -r -ta%backup_param1% Haiding_%backup_param1%_Web.rar $$WEB目录物理地址$$\*.* >> Haiding_%backup_param1%_Backuplog.log

set backup_param1=
set backup_param2=
set backup_param3=

