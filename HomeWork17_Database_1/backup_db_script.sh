#!/bin/bash

# Настройки
USER="root"
PASSWORD="1q2w3e4r5t"
DATABASE="Analysis_db"
BACKUP_DIR="/home/$(whoami)/backups"
BACKUP_FILE="${BACKUP_DIR}/$(date +'%Y-%m-%d_%H-%M-%S')_backup.sql"
REMOTE_SERVER="osboxes@192.168.8.8"
SERVER= "192.168.8.8"
REMOTE_DIR="/remote/backups"
LOG_FILE="${BACKUP_DIR}/backup.log"

# Логи
mkdir -p $BACKUP_DIR
exec > >(tee -a $LOG_FILE) 2>&1

# Проверка свободного места
if [ $(df --output=avail "$BACKUP_DIR" | tail -1) -lt 100000 ]; then
    echo "Ошибка: недостаточно свободного места для создания бэкапа!"
    exit 1
fi

# Создание бэкапа
mysqldump -u $USER -p$PASSWORD $DATABASE > $BACKUP_FILE
if [ $? -ne 0 ]; then
    echo "Ошибка: не удалось создать бэкап базы данных!"
    exit 1
fi

# Проверка доступности удалённого сервера
if ! ping -c 1 -W 2 $SERVER >/dev/null; then
    echo "Ошибка: удалённый сервер недоступен!"
    exit 1
fi

# Отправка бэкапа на удалённый сервер
scp $BACKUP_FILE $REMOTE_SERVER:$REMOTE_DIR
if [ $? -ne 0 ]; then
    echo "Ошибка: не удалось отправить бэкап на удалённый сервер!"
    exit 1
fi

# Удаление старых бэкапов
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \; || echo "Ошибка: не удалось удалить старые бэкапы"

echo "Бэкап базы данных успешно создан и отправлен на удалённый сервер: $BACKUP_FILE"
