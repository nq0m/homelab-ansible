#!/bin/bash
# Backup Script
# Uses borg to backup the machine
# 10/2/2021

#Set environment variables
export myHOSTNAME=`uname -n`
export myDATE=`date +%Y-%m-%d`
export BORG_PASSPHRASE="2Az2inKeFSufBe8zmTGXtGYvkojO2y6P"
export BORG_REPO="/backups/borg"
export LOG_FILE="/var/log/backup_script.log"

startTime=`date +%Y-%m-%d\ %H:%M`
/usr/bin/echo "Backups starting at:  ${startTime}" > $LOG_FILE

#Create a directory for the backups mount point
/usr/bin/mkdir /backups

#Mount the backups
/usr/bin/mount -t nfs 172.17.10.30:/nfs/LinuxBackups /backups

#Did we successfully mount the NFS share?
if [ -d "${BORG_REPO}" ]
then
  echo "NFS successfully mounted to /backups!" >> $LOG_FILE
else
  echo "ERROR: Failed to mount NFS share to /backups!" >> $LOG_FILE
  exit 1
fi

#Run restic to perform the backup
/usr/bin/borg create --exclude-from /jobs/backup_excludes --list -s ::${myHOSTNAME}-${myDATE} / 2>> $LOG_FILE

# One backup is completed, umount the NFS
/usr/bin/umount /backups

if [ ! -d "${BORG_REPO}" ]
then
  echo "NFS successfully unmounted!" >> $LOG_FILE
  /usr/bin/rmdir /backups
  echo "/backups directory removed!" >> $LOG_FILE
else
  echo "NFS was not successfully unmounted!" >> $LOG_FILE
  exit 1
fi

endTime=`date +%Y-%m-%d\ %H:%M`
/usr/bin/echo "Backups ending at: ${endTime}" >> $LOG_FILE
