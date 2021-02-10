#!/usr/bin/env bash
#########################################################################
#Name: backup-docker-compose.sh
#Subscription: This Script backups the docker compose project folder
#to a backup directory
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
BACKUPDIR=/backup/compose

# How many Days should a backup be available?
DAYS=2

# Timestamp definition for the backupfiles (example: $(date +"%Y%m%d%H%M") = 20200124-2034)
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Which Docker Compose Project you want to backup?
# Docker Compose Project pathes separated by space 
#COMPOSE="/opt/project1 /opt/project2"
# you can use the following two big command to read out all compose projects
# uncommend if you like to read automatic all projects:
ALLCONTAINER=$(docker ps --format '{{.Names}}')
ALLPROJECTS=$(for i in $ALLCONTAINER; do docker inspect --format '{{ index .Config.Labels "com.docker.compose.project.working_dir"}}' $i; done | sort -u)
# then to use all projects without filtering it:
COMPOSE=$ALLPROJECTS
# you can filter all Compose Projects with grep (include only) or grep -v (exclude) or a combination
# to do a filter for 2 or more arguments separate them with "\|"
# example: $(echo $ALLPROJECTS |grep 'project1\|project2' | grep -v 'database')
# to use volumes with name project1 and project2 but not database
#COMPOSE=$(echo -e "$ALLPROJECTS" | grep 'project1\|project2' | grep -v 'database')
#COMPOSE=$(echo -e "$ALLPROJECTS" | grep -v 'mailcow-dockerized')


### Do the stuff
echo -e "Start $TIMESTAMP Backup for Docker Compose Projects:\n"
if [ ! -d $BACKUPDIR ]; then
	mkdir -p $BACKUPDIR
fi

for i in $COMPOSE; do
	PROJECTNAME=${i##*/}
	echo -e " Backup von Compose Project:\n  * $PROJECTNAME";
	cd $i
	tar -czf $BACKUPDIR/$PROJECTNAME-$TIMESTAMP.tar.gz .
	# dont delete last old backups!
	OLD_BACKUPS=$(ls -1 $BACKUPDIR/$PROJECTNAME*.tar.gz |wc -l)
	if [ $OLD_BACKUPS -gt $DAYS ]; then
		find $BACKUPDIR -name "$PROJECTNAME*.tar.gz" -daystart -mtime +$DAYS -delete
	fi
done
echo -e "\n$TIMESTAMP Backup for Compose Projects completed\n"
