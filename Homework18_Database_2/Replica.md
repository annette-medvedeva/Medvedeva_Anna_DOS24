Шаг 1: Подготовка серверов и установка MySQL
Создать два сервера Ubuntu в AWS:

EC2 для создания двух инстансов Ubuntu.
Настройте обе машины на одной сети (в одной VPC, подсети и группе безопасности).

Установите MySQL на обоих серверах:
sudo apt update
sudo apt install mysql-server -y

Проверить статус MySQL:
sudo systemctl status mysql

Настроить доступ между серверами:

В группе безопасности AWS разрешить MySQL-порт 3306 между двумя серверами.

Шаг 2: Настройка репликации (зеркалирование)
Подготовка главного сервера (Master):

Отредактировать файл конфигурации MySQL:
 
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
Добавить параметры:

[mysqld]
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog_do_db = your_database_name  # Замените на имя вашей базы
Перезапустите MySQL:
 
sudo systemctl restart mysql

Создать пользователя для репликации: Войдите в MySQL:
mysql -u root -p

Выполнить:
CREATE USER 'replica_user'@'%' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
FLUSH PRIVILEGES;

SHOW MASTER STATUS;

Сохранить значение File и Position из результата.

Подготовка реплики (Slave):

Настроить конфигурацию MySQL:
 
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

Добавить:
[mysqld]
server-id = 2
relay-log = /var/log/mysql/mysql-relay-bin.log


Перезапустить MySQL:
sudo systemctl restart mysql


Настроить репликацию: 
Войти в MySQL на втором сервере:
 
mysql -u root -p

CHANGE MASTER TO
MASTER_HOST='IP_главного_сервера',
MASTER_USER='replica_user',
MASTER_PASSWORD='password',
MASTER_LOG_FILE='mysql-bin.000001',  -- Значение из Master
MASTER_LOG_POS=756;  -- Значение из Master
START SLAVE;

SHOW SLAVE STATUS\G;

Шаг 3: Настройка отказоустойчивости (кластер)
Установить MySQL Router или MySQL InnoDB Cluster:

Установить mysql-shell на оба сервера:
 
sudo apt install mysql-shell

Настройте InnoDB Cluster на мастер-ноде:
 
mysqlsh
\connect root@localhost
dba.createCluster('myCluster')
cluster.addInstance('root@IP_второго_сервера')


Проверить статус кластера: В mysqlsh выполнить:

cluster.status()

Настроить автоматическое переключение:

Убедитесь, что кластер настроен на использование автоматического failover:
 
cluster.setOption('autoRejoinTries', 3)
cluster.setOption('autoIncrementIncrement', 2)

Шаг 4: Тестирование отказоустойчивости
Отказ главного сервера:

Остановить MySQL на мастере:
 
sudo systemctl stop mysql
Проверить доступность данных:

Выполнить запросы на реплике.
Восстановить главный сервер:

Запустить MySQL на мастере:
 
sudo systemctl start mysql


Шаг 5: Настройка резервного копирования (опционально)

Установить mysqldump или Xtrabackup:

sudo apt install percona-xtrabackup-80
Создайть скрипт для бэкапа:
nano /home/ubuntu/mysql_backup.sh

Содержание:

#!/bin/bash
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
mysqldump -u root -p --all-databases > "$BACKUP_DIR/all_databases.sql"


Настроить автоматизацию с помощью cron:

crontab -e
Добавить:
0 2 * * * /home/ubuntu/mysql_backup.sh
