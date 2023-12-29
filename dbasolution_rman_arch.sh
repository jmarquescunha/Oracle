####################################################################################################
#----------------------------------------------------
# DBA SOLUTION - GOIANIA/GO
# Script: dbasolution_rman_arch.sh
# Versao: 4.0 - 17/07/2012
#----------------------------------------------------
#EXPORTANDO AS VARIAVEIS DO BANCO ORACLE
export ADMIN=/home/oracle/scripts
export HISTFILE=/home/oracle/.bash_history
export HOME=/home/oracle
export HOSTNAME=srvoracle
export LOGNAME=oracle
export MAIL=/var/spool/mail/oracle
export OLDPWD=/home/oracle
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/11.2/db_1
export PATH=/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/oracle/bin:/u01/app/oracle/product/11.2/db_1/bin
export PWD=/home/oracle/scripts
export USER=oracle
export ORACLE_SID=ORCL

#EXPORTANDO OS VARIAVEIS DO SCRIPT
export VDATA=`date +%d%m%y_%H%M`
export VDATA_SERV=`date`
export log_bkp="/backup/rman/ORCL/logs/dbasolution_logarch_$VDATA.log"
export log_execucao="/backup/rman/ORCL/logs/dbasolution_execucao_rman_arch_$VDATA.log"
export DIRETORIO="/backup/rman/ORCL/logs"
export ERROLOGRMAN="/backup/rman/ORCL/logs/dbasolution_rman_arch_erros_$VDATA.txt"
export ARQ_RMAN_DBAREMOTO="/backup/rman/ORCL/logs/dbasolution_logs_rman_arch_dbaremoto_$VDATA.txt"

#LIMPEZA DOS LOGS ANTIGOS
cd $DIRETORIO
find . -name "*.log" -mtime +2 -exec rm {} \;
find . -name "*.txt" -mtime +2 -exec rm {} \;

LOCK=/home/oracle/scripts/dbasolution_arch_rman.lock
if [ -f $LOCK ]; then
echo "+------------------------------------+" >> $log_execucao
  echo "BACKUP RMAN ARCHIVELOGS, AGUARDANDO O BACKUP RMAN ARCHIVELOGS!!!" >> $log_execucao
  echo "BACKUP..." $VDATA >> $log_execucao
  exit
fi
touch $LOCK

echo "+----------------------------------------+" >> $log_execucao
echo "Iniciando execucao BACKUP RMAN ARCHIVELOGS" >> $log_execucao
date >> $log_execucao
rman target / CATALOG RMAN/DBASOLUTION@RMAN LOG $log_bkp <<EOF
run
{
configure backup optimization on;
configure retention policy to recovery window of 1 days;
configure device type disk parallelism 1;
configure channel 1 device type disk format '/backup/rman/ORCL/RMAN_ARCH_%d_%s_%p_%T.arch';
configure channel device type disk maxpiecesize 5G;
configure controlfile autobackup on;
sql 'ALTER SYSTEM ARCHIVE LOG CURRENT';
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/backup/rman/ORCL/RMAN_CONTROL_FILE_ARCH_%F.arch';
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/backup/rman/ORCL/snapctrlfile.ctl';
crosscheck archivelog all;
delete expired archivelog all;
BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'RMAN_ARCH_ORCL_CF';
BACKUP SPFILE TAG 'RMAN_ARCH_SPFILE_ORCL' FORMAT '/backup/rman/ORCL/RMAN_ARCH_SPFILE_ORCL_%D_%M_%Y_%t.arch';
BACKUP archivelog all NOT BACKED UP 1 TIMES;
delete noprompt archivelog all completed before 'sysdate - (1/24)';
}

exit;
EOF

echo "Finalizando execucao BACKUP RMAN ARCHIVELOGS" >> $log_execucao
date >> $log_execucao
echo "+----------------------------------------+" >> $log_execucao

rm -f $LOCK

#CHECAGEM DE ERROS DO BACKUP RMAN FULL
if cat $log_bkp | grep -i RMAN- >> $ERROLOGRMAN
then
        echo "######################################################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#############" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- RELACAO DOS ERRO BACKUP ARCHIVELOGS RMAN ---###" >> $ARQ_RMAN_DBAREMOTO
        cat $ERROLOGRMAN >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#############" >> $ARQ_RMAN_DBAREMOTO
        echo "######################################################" >> $ARQ_RMAN_DBAREMOTO
else
        echo "######################################################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#############" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- BACKUP ARCHIVELOGS RMAN ---####################" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- NAO HOUVE ERROS NA EXECUCAO RMAN!!! ---########" >> $ARQ_RMAN_DBAREMOTO
        echo "###--- " $VDATA_SERV " ---#############" >> $ARQ_RMAN_DBAREMOTO
        echo "######################################################" >> $ARQ_RMAN_DBAREMOTO
exit 1
fi
# FIM DO SCRIPT dbasolution_backup_rman_arch.sh
