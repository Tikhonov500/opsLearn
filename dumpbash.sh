#!/bin/bash

DUMPBASH_DIR=$(dirname "$0")

config_file="$DUMPBASH_DIR/config.txt"

source $config_file

 mysqldump -u "$USER" -p"$PASSWORD" "$DBNAME" | gzip -c > "$BACKUP_DIR/$TODAY".gz

if [ $? -eq 0 ]; then
	echo "Success"
	
	TARGZ_NAME="$BACKUP_DIR/$TODAY.gz"
	scp -i "$FIRST_SERVER_PEM" "$TARGZ_NAME" "$FIRST_SERVER_USER"@"$FIRST_SERVER_IP":/"$FIRST_SERVER_DIR"
	
	if [ $? -eq 0 ]; then
		echo "Success copy on remote Server"
	else
		echo "Error"
	fi
else 
	echo "Error Backup"
fi
