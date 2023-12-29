mkdir /db
cd /
cd db
mkdir oradata
cd oradata
mkdir WINT
cd WINT
mkdir admin
cd admin
mkdir adump
mkdir udump
mkdir cdump
mkdir bdump
mkdir diag

cd /db/oradata/WINT
mkdir archive
mkdir rman
cd rman
mkdir logs
mkdir data
mkdir archivelogs
mkdir controlfile
cd ..
mkdir flashback
mkdir espelhoredo
mkdir espelhocontrole
mkdir undo 
mkdir indices
mkdir temporario
mkdir datapump
mkdir controlestandby
mkdir dados
mkdir redo
mkdir dicionario
mkdir controle 

cd /
chown -R oracle.oinstall /db
chmod -R 775 /db
cd /oracle
mkdir -p /oracle/install
chown -R oracle.oinstall /oracle/install
mkdir -p /oracle/app/oraInventory
chown -R oracle.oinstall /oracle/app/oraInventory
chmod -R 775 /oracle/app/oraInventory
mkdir -p /oracle/app/oracle/cfgtoollogs
chown -R oracle.oinstall /oracle/app/oracle
chmod -R 775 /oracle/app/oracle
mkdir -p /oracle/app/oracle/product/11.2/db_1
chown -R oracle.oinstall /oracle/app/oracle/product/11.2/db_1
chmod -R 775 /oracle/app/oracle/product/11.2/db_1
mkdir -p /db/oradata/WINT/rman/copiabackup/
chown -R oracle.oinstall /db/oradata/WINT/rman/copiabackup/
chmod -R 775 /db/oradata/WINT/rman/copiabackup/
mkdir -p /db/oradata/WINT/datapump/copiabackup
chown -R oracle.oinstall /db/oradata/WINT/datapump/copiabackup/
chmod -R 775 /db/oradata/WINT/datapump/copiabackup/

cd /
mkdir -p /sistema/winthor
chmod 660 /etc/rc.local
cd /
cd /home/oracle
mkdir scripts
chown -R oracle.oinstall /home/oracle/scripts
cd /mnt
mkdir hdext
chown -R oracle.oinstall /mnt/hdext
chmod 775 /mnt/hdext


