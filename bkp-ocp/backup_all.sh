#!/bin/bash

echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
echo "#------- INICIO BACKUP OCP - `date +'%d-%m-%Y %H:%M'` -------------------#" >> /backupOCP/bkp_log
echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log

echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Configs Masters" >> /backupOCP/bkp_log
ansible-playbook -i inventory.dc1.example.com /root/bkp-ocp/backup-masters.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Etcds" >> /backupOCP/bkp_log
ansible-playbook -i inventory.dc1.example.com /root/bkp-ocp/backup-etcds.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Configs Nodes" >> /backupOCP/bkp_log
ansible-playbook -i inventory.dc1.example.com /root/bkp-ocp/backup-nodes.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Objects de Todos os Projetos" >> /backupOCP/bkp_log
ansible-playbook -i inventory.dc1.example.com /root/bkp-ocp/backup-objects.yaml &&
echo "[`date +'%d-%m-%Y %H:%M'`] - Playbook Backup Inventarios" >> /backupOCP/bkp_log
ansible-playbook -i inventory.dc1.example.com  /root/bkp-ocp/backup-ocp_configs.yaml 

echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
echo "#------- FIM BACKUP OCP - `date +'%d-%m-%Y %H:%M'` ----------------------#" >> /backupOCP/bkp_log
echo "#----------------------------------------------------------------#" >> /backupOCP/bkp_log
