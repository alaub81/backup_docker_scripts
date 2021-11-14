# backup_docker_scripts
with these script you are able to backup your docker environment. There is one for the compose project, for one mysql or mariadb, one for postgres SQL and one for the docker volumes.

# Installation
Just download the needed Script/s to `/usr/local/sbin` and give them the excute (`chmod +x SCRIPTNAME`) then you could just start it from wherever you are in the filesystem.

# Usage
## backup-docker-volume.sh
This Script backups docker volumes of the system to a defined Path. You could define the volumes and the backup path in the script itself. Also you could configure the days, how long the backup files will remain as backup. After configuration of the script, you could just start it with
`backup-docker-volume.sh`

## backup-docker-mysql.sh


## backup-docker-postgres.sh


## backup-docker-compose.sh




# More Informations you could find here:
* https://www.laub-home.de/wiki/Docker_Backup_und_Restore_-_eine_kleine_Anleitung
* https://www.laub-home.de/wiki/Docker_Postgres_Backup_Script
* https://www.laub-home.de/wiki/Docker_Volume_Backup_Script
* https://www.laub-home.de/wiki/Docker_MySQL_and_MariaDB_Backup_Script
* https://www.laub-home.de/wiki/Docker_Compose_Project_Backup_Script
