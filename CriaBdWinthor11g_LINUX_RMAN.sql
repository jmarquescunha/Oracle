CREATE DATABASE RMAN
LOGFILE
GROUP 1 ('+DATA/db/oradata/RMAN/redo/redo01.log') SIZE 125M,
GROUP 2 ('+DATA/db/oradata/RMAN/redo/redo02.log') SIZE 125M,
GROUP 3 ('+DATA/db/oradata/RMAN/redo/redo03.log') SIZE 125M,
GROUP 4 ('+DATA/db/oradata/RMAN/redo/redo04.log') SIZE 125M,
GROUP 5 ('+DATA/db/oradata/RMAN/redo/redo05.log') SIZE 125M,
GROUP 6 ('+DATA/db/oradata/RMAN/redo/redo06.log') SIZE 125M,
GROUP 7 ('+DATA/db/oradata/RMAN/redo/redo07.log') SIZE 125M,
GROUP 8 ('+DATA/db/oradata/RMAN/redo/redo08.log') SIZE 125M,
GROUP 9 ('+DATA/db/oradata/RMAN/redo/redo09.log') SIZE 125M,
GROUP 10 ('+DATA/db/oradata/RMAN/redo/redo10.log') SIZE 125M
ARCHIVELOG
CHARACTER SET WE8ISO8859P1
DATAFILE '+DATA/db/oradata/RMAN/dicionario/system01.dbf' SIZE 500M
sysaux datafile '+DATA/db/oradata/RMAN/dicionario/sysaux01.dbf' size 500M
undo tablespace TS_UNDO datafile '+DATA/db/oradata/RMAN/undo/ts_undo01.dbf' size 500M default temporary tablespace
TS_TEMP tempfile '+DATA/db/oradata/RMAN/temporario/ts_temp01.dbf' size 500M;

alter user sys identified by manager
/
connect sys/manager as sysdba

@$ORACLE_HOME/rdbms/admin/catalog.sql
/
@$ORACLE_HOME/rdbms/admin/catproc.sql
/