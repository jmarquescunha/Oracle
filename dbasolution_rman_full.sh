###################################################################################################
#----------------------------------------------------
# Tecnomix Tecnologia Ltda
# Script: dbasolution_backup_rman_full.sh
# Versao: 4.0 - 17/07/2012
#----------------------------------------------------
#EXPORTANDO AS VARIAVEIS DO BANCO ORACLE
export ADMIN=/home/oracle/scripts
export HISTFILE=/home/oracle/.bash_history
export HOME=/home/oracle
export HOSTNAME=db-primario
export LOGNAME=oracle
export MAIL=/var/spool/mail/oracle
export OLDPWD=/home/oracle
export ORACLE_BASE=/oracle/app/oracle
export ORACLE_HOME=/oracle/app/oracle/product/11.2/db_1
export PATH=/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/oracle/bin:/oracle/app/oracle/product/11.2/db_1/bin
export PWD=/home/oracle/scripts
export USER=oracle
export ORACLE_SID=WINT

#EXPORTANDO OS VARIAVEIS DO SCRIPT
export VDATA=`date +%d%m%y_%H%M`
export VDATA_SERV=`date`
export log_bkp="/backup2/dbora/rman/WINT/logs/dbasolution_logfull_$VDATA.log"
export log_execucao="/backup2/dbora/rman/WINT/logs/dbasolution_execucao_rman_full_$VDATA.log"
export DIRETORIO="/backup2/dbora/rman/WINT/logs"
export ERROLOGRMAN="/backup2/dbora/rman/WINT/logs/dbasolution_rman_full_erros_$VDATA.txt"
export ARQ_RMAN_DBAREMOTO="/backup2/dbora/rman/WINT/logs/dbasolution_logs_rman_full_dbaremoto_$VDATA.txt"

#LIMPEZA DOS LOGS ANTIGOS
cd $DIRETORIO
find -mtime +5 -name "*.txt" -exec rm -f {} \;
find -mtime +5 -name "*.log" -exec rm -f {} \;

LOCK=/home/oracle/scripts/dbasolution_fullrman.lock
if [ -f $LOCK ]; then
  echo "+-----------------------------------+" >> $log_execucao
  echo "BACKUP RMAN FULL, AGUARDANDO O BACKUP FULL RMAN!!!" >> $log_execucao
  echo "BACKUP..." $VDATA >> $log_execucao
  exit
fi
touch $LOCK

echo "+--------------------------------------------+" >> $log_execucao
echo "Iniciando execucao BACKUP RMAN FULL" >> $log_execucao
date >> $log_execucao
rman target / CATALOG RMAN/DBASOLUTION@RMAN LOG $log_bkp <<EOF
run
{
configure backup optimization off;
configure retention policy to recovery window of 1 days;
configure channel 1 device type disk format '/backup2/dbora/rman/WINT/RMAN_FULL_%d_%s_%p_%T.bkp';
configure device type disk parallelism 1;
configure channel device type disk maxpiecesize 5G;
configure controlfile autobackup on;
crosscheck backup;
delete noprompt obsolete;
sql 'alter system switch logfile';
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/backup2/dbora/rman/WINT/RMAN_CONTROL_FILE_%F.bkp';
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/backup2/dbora/rman/WINT/snapctrlfile.ctl';
BACKUP AS COMPRESSED BACKUPSET DATABASE TAG 'RMAN_FULL_WINT' PLUS ARCHIVELOG NOT BACKED UP 1 TIMES;
BACKUP SPFILE TAG 'RMAN_FULL_SPFILE_WINT' FORMAT '/backup2/dbora/rman/WINT/RMAN_FULL_SPFILE_WINT_%D_%M_%Y_%t.bkp';
crosscheck backup;
restore validate database;
delete noprompt obsolete;
}
exit;
EOF

echo "Finalizando execucao BACKUP RMAN FULL" >> $log_execucao
date >> $log_execucao
echo "+--------------------------------------------+" >> $log_execucao

rm -f $LOCK

#CHECAGEM DE ERROS DO BACKUP RMAN FULL
if cat $log_bkp | grep -i RMAN- >> $ERROLOGRMAN
then
        echo "###############################################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- RELACAO DOS ERRO BACKUP FULL RMAN ---###" >> $ARQ_RMAN_DBAREMOTO
        cat $ERROLOGRMAN >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###############################################" >> $ARQ_RMAN_DBAREMOTO
else
        echo "###############################################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- BACKUP FULL RMAN ---####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- NAO HOUVE ERROS NA EXECUCAO !!!  ---####" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###############################################" >> $ARQ_RMAN_DBAREMOTO
exit 1
fi
# FIM DO SCRIPT: dbasolution_backup_rman_full.sh
