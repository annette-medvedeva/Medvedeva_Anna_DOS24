#!/bin/bash
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
mysqldump -u root -p --all-databases > "$BACKUP_DIR/all_databases.sql"