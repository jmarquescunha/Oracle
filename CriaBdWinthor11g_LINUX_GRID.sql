CREATE DATABASE WINT
LOGFILE
GROUP 1 ('+DATA/db/oradata/WINT/redo/redo01.log') SIZE 125M,
GROUP 2 ('+DATA/db/oradata/WINT/redo/redo02.log') SIZE 125M,
GROUP 3 ('+DATA/db/oradata/WINT/redo/redo03.log') SIZE 125M,
GROUP 4 ('+DATA/db/oradata/WINT/redo/redo04.log') SIZE 125M,
GROUP 5 ('+DATA/db/oradata/WINT/redo/redo05.log') SIZE 125M,
GROUP 6 ('+DATA/db/oradata/WINT/redo/redo06.log') SIZE 125M,
GROUP 7 ('+DATA/db/oradata/WINT/redo/redo07.log') SIZE 125M,
GROUP 8 ('+DATA/db/oradata/WINT/redo/redo08.log') SIZE 125M,
GROUP 9 ('+DATA/db/oradata/WINT/redo/redo09.log') SIZE 125M,
GROUP 10 ('+DATA/db/oradata/WINT/redo/redo10.log') SIZE 125M
ARCHIVELOG
CHARACTER SET WE8ISO8859P1
DATAFILE '+DATA/db/oradata/WINT/dicionario/system01.dbf' SIZE 2000M REUSE EXTENT MANAGEMENT LOCAL
sysaux datafile '+DATA/db/oradata/WINT/dicionario/sysaux01.dbf' size 2000M REUSE
SMALLFILE DEFAULT TEMPORARY TABLESPACE TS_TEMP TEMPFILE '+DATA/db/oradata/WINT/temporario/ts_temp01.dbf' SIZE 2000M REUSE
SMALLFILE UNDO TABLESPACE "TS_UNDO" DATAFILE '+DATA/db/oradata/WINT/undo/ts_undo01.dbf' SIZE 2000M REUSE;

alter user sys identified by manager
/
connect sys/manager as sysdba

@$ORACLE_HOME/rdbms/admin/catalog.sql
/
@$ORACLE_HOME/rdbms/admin/catproc.sql
/