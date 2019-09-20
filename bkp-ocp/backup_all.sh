#!/bin/bash

echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
echo "#------- INICIO BACKUP OCP - `date +'%d-%m-%Y %H:%M'` -------------------#" >> /backupOCP/bkp_log
echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log

echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Configs Masters" >> /backupOCP/bkp_log
ansible-playbook -i /root/bkp-ocp/ocp_install /root/bkp-ocp/backup-masters.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Etcds" >> /backupOCP/bkp_log
ansible-playbook -i /root/bkp-ocp/ocp_install /root/bkp-ocp/backup-etcds.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Configs Nodes" >> /backupOCP/bkp_log
ansible-playbook -i /root/bkp-ocp/ocp_install /root/bkp-ocp/backup-nodes.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Objects de Todos os Projetos" >> /backupOCP/bkp_log
ansible-playbook -i /root/bkp-ocp/ocp_install /root/bkp-ocp/backup-objects.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Inventarios" >> /backupOCP/bkp_log
ansible-playbook -i /root/bkp-ocp/ocp_install  /root/bkp-ocp/backup-ocp_configs.yaml 

echo "[`date +'%d-%m-%Y %H:%M'`] - Executando compressao do backup e remocao de backup anteriores a 15 dias" >> /backupOCP/bkp_log
/root/bkp-ocp/compression.sh 

echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
echo "#------- FIM BACKUP OCP - `date +'%d-%m-%Y %H:%M'` ----------------------#" >> /backupOCP/bkp_log
echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
