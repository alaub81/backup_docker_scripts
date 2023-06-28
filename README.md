# Repository Description
with these script you are able to backup your docker environment. There is one for the compose project, for one mysql or mariadb, one for postgres SQL and one for the docker volumes.

## Installation

Just download the needed Script/s to `/usr/local/sbin` and give them the excute (`chmod +x SCRIPTNAME`) then you could just start it from wherever you are in the filesystem.

## Usage

### backup-docker-volume.sh

This Script backups docker volumes of the system to a defined Path. You could define the volumes and the backup path in the script itself. Also you could configure the days, how long the backup files will remain as backup. After configuration of the script, you could just start it with:

`backup-docker-volume.sh`

### backup-docker-mysql.sh

This Script backups mysql or mariaDB containers with `mysqldump`. Just define the backup folder in the script and start it with:

`backup-docker-mysql.sh`

You can also configure the days, the backupfiles will remain in the backup folder.

Attention: If you are using Docker Secrets, it will not work. More informations here: [#1](https://github.com/alaub81/backup_docker_scripts/issues/1)

### backup-docker-postgres.sh

This Script backups postgres database containers with `pg_dumpall`. Just define the backup folder in the script and start it with:

`backup-docker-postgres.sh`

You can also configure the days, the backupfiles will remain in the backup folder.

### backup-docker-influxdb.sh

This Script backups influxdb database containers with `influx backup`. Just define the backup folder in the script mount it into the container under `/backup` and start it with:

`backup-docker-influxdb.sh`

You can also configure the days, the backupfiles will remain in the backup folder.

### backup-docker-compose.sh

With the help of `backup-docker-compose.sh` you are able to backup the whole docker-compose project folder of each docker-compose project you are running. It uses `tar.gz` to archive all the files and folders to the predifined backup folder. Just configure the script in the top and run it:

`backup-docker-compose.sh`

You can also configure the days, the backupfiles will remain in the backup folder.

## More Informations you could find here:

* https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
* https://www.laub-home.de/wiki/Docker_Postgres_Backup_Script
* https://www.laub-home.de/wiki/Docker_InfluxDB_2_Backup_Script
* https://www.laub-home.de/wiki/Docker_Volume_Backup_Script
* https://www.laub-home.de/wiki/Docker_MySQL_and_MariaDB_Backup_Script
* https://www.laub-home.de/wiki/Docker_Compose_Project_Backup_Script
