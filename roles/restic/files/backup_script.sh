#!/bin/bash
# Backup Script
# Uses restic to backup the machine to home
# 10/25/2019

#Set environment variables for restic
export RESTIC_REPOSITORY="rest:http://172.17.20.13:8080/"
export RESTIC_PASSWORD="2Az2inKeFSufBe8zmTGXtGYvkojO2y6P"

startTime = `date +%Y-%m-%d %H:%M`
/usr/bin/echo "Backups starting at:  ${startTime}" > /var/log/backup_script.log

#Run restic to perform the backup
/usr/local/bin/restic --exclude-file=/jobs/backup_excludes backup / >> /var/log/backup_script.log

endTime = `date +%Y-%m-%d %H:%M`

/usr/bin/echo "Backups ending at: ${endTime}" >> /var/log/backup_script.log
