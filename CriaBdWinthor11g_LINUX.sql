CREATE DATABASE WINT
LOGFILE
GROUP 1 ('/u01/app/oracle/oradata/WINT/redo/redo01.log') SIZE 125M,
GROUP 2 ('/u01/app/oracle/oradata/WINT/redo/redo02.log') SIZE 125M,
GROUP 3 ('/u01/app/oracle/oradata/WINT/redo/redo03.log') SIZE 125M,
GROUP 4 ('/u01/app/oracle/oradata/WINT/redo/redo04.log') SIZE 125M,
GROUP 5 ('/u01/app/oracle/oradata/WINT/redo/redo05.log') SIZE 125M
ARCHIVELOG
CHARACTER SET WE8ISO8859P1
DATAFILE '/u01/app/oracle/oradata/WINT/datafiles/system01.dbf' SIZE 2000M REUSE EXTENT MANAGEMENT LOCAL
sysaux datafile '/u01/app/oracle/oradata/WINT/datafiles/sysaux01.dbf' size 2000M REUSE
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE '/u01/app/oracle/oradata/WINT/datafiles/ts_temp01.dbf' SIZE 2000M REUSE
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE '/u01/app/oracle/oradata/WINT/datafiles/ts_undo01.dbf' SIZE 2000M REUSE;

alter user sys identified by manager
/
connect sys/manager as sysdba

@$ORACLE_HOME/rdbms/admin/catalog.sql
/
@$ORACLE_HOME/rdbms/admin/catproc.sql
/