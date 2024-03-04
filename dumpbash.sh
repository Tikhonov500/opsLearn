#!/bin/bash

config_file="config.txt"

source $config_file

mysqldump -u "$USER" -p"$PASSWORD" "$DBNAME" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
	echo "Success"

	tar -czvf "$BACKUP_DIR/$TODAY.tar.gz" "$BACKUP_FILE"

	ARCHIVE_NAME="$BACKUP_DIR/$TODAY.tar.gz"

	scp -i "$FIRST_SERVER_PEM" "$ARCHIVE_NAME" "$FIRST_SERVER_USER"@"$FIRST_SERVER_IP":/"$FIRST_SERVER_DIR"
	

	if [ $? -eq 0 ]; then
		echo "Success tar and copy on remote Server"
	else
		echo "Error"
	fi
else 
	echo "Error Backup"
fi
