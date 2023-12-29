#!/bin/bash
DATA=`date +%d%m%Y`
if
        mount -t ntfs-3g -o nls=utf8,umask=0222 /dev/sdb1 /hdexterno
then
        cd /backup/datapump
        cp -v --preserve=timestamps *.tar.gz /hdexterno
        cp -v --preserve=timestamps *.dmp /hdexterno
        cd /hdexterno
        rm -f `find -mtime +60 -name '*.tar.z'`
        cd /hdexterno
        rm -f `find -mtime +60 -name '*.dmp'`
        cd /
        umount -l /hdexterno
fi
