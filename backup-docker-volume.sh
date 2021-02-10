#!/bin/bash
#########################################################################
#Name: backup-docker-volumes.sh
#Subscription: This Script backups docker volumes to a backup directory
##by A. Laub
#andreas[-at-]laub-home.de
#
#License:
#This program is free software: you can redistribute it and/or modify it
#under the terms of the GNU General Public License as published by the
#Free Software Foundation, either version 3 of the License, or (at your option)
#any later version.
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#or FITNESS FOR A PARTICULAR PURPOSE.
#########################################################################
#Set the language
export LANG="en_US.UTF-8"
#Load the Pathes
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# set the variables

# Where to store the Backup files?
BACKUPDIR=/backup/volumes

# How many Days should a backup be available?
DAYS=2

# Timestamp definition for the backupfiles (example: $(date +"%Y%m%d%H%M") = 20200124-2034)
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Which Volumes you want to backup?
# Volumenames separated by space 
#VOLUME="project1_data_container1 project2_data_container1"
# you can use "$(docker volume ls  -q)" for all volumes
VOLUME=$(docker volume ls -q)
# you can filter all Volumes with grep (include only) or grep -v (exclude) or a combination
# to do a filter for 2 or more arguments separate them with "\|"
# example: $(docker volume ls -q |grep 'project1\|project2' | grep -v 'database')
# to use volumes with name project1 and project2 but not database
#VOLUME=$(docker volume ls -q |grep 'project1\|project2' | grep -v 'database')
#VOLUME=$(docker volume ls -q | grep -v 'mailcowdockerized\|_db')

# if you want to use memory limitation. Must be supported by the kernel.
#MEMORYLIMIT="-m 35m"

### Do the stuff
echo -e "Start $TIMESTAMP Backup for Volumes:\n"
if [ ! -d $BACKUPDIR ]; then
	mkdir -p $BACKUPDIR
fi

for i in $VOLUME; do 
	echo -e " Backup von Volume:\n  * $i"; 
	docker run --rm \
        -v $BACKUPDIR:/backup \
        -v $i:/data:ro \
	-e TIMESTAMP=$TIMESTAMP \
	-e i=$i	${MEMORYLIMIT} \
	--name volumebackup \
        alpine sh -c "cd /data && /bin/tar -czf /backup/$i-$TIMESTAMP.tar.gz ."
        #debian:stretch-slim bash -c "cd /data && /bin/tar -czf /backup/$i-$TIMESTAMP.tar.gz ."
	# dont delete last old backups!
        OLD_BACKUPS=$(ls -1 $BACKUPDIR/$i*.tar.gz |wc -l)
	if [ $OLD_BACKUPS -gt $DAYS ]; then
		find $BACKUPDIR -name "$i*.tar.gz" -daystart -mtime +$DAYS -delete
	fi
done
echo -e "\n$TIMESTAMP Backup for Volumes completed\n"
