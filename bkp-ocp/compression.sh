#!/bin/bash

cd /backupOCP
DATE=$(date '+%Y-%m-%d')
/usr/bin/tar czvf ocp_$DATE.tgz  $DATE &&
rm -rf /backupOCP/$DATE
find /backupOCP/ -mtime +15 -exec rm -rf {} \;
