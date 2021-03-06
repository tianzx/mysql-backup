#!/bin/bash

USER="root"
PASSWORD="Smartautotech@123"
OUTPUT="/backup/dbbackup"

rm "$OUTPUT/*gz" > /dev/null 2>&1

databases=`/usr/local/mysql/bin/mysql --user=$USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
        echo $db
        if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        if [ ! -d $OUTPUT ]; then
             sudo mkdir -p "$OUTPUT/"
             echo "success"
        fi
        /usr/local/mysql/bin/mysqldump --force --opt --user=$USER --password=$PASSWORD --databases $db > $OUTPUT/`date +%Y%m%d`.$db.sql
        gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done