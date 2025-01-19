Шаг 1: Подготовка серверов и установка MySQL
Создать два сервера Ubuntu в AWS:

EC2 для создания двух инстансов Ubuntu.
Настройте обе машины на одной сети (в одной VPC, подсети и группе безопасности).
![aws] (https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/Screenshot%20from%202025-01-19%2019-26-19.png')

Установите MySQL на обоих серверах:
sudo apt update
sudo apt install mysql-server -y

Проверить статус MySQL:
sudo systemctl status mysql

Настроить доступ между серверами:

В группе безопасности AWS разрешить MySQL-порт 3306 между двумя серверами.
![security group](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/Screenshot%20from%202025-01-19%2019-31-38.png)


Шаг 2: Настройка репликации (зеркалирование)
Подготовка главного сервера (Master):

Отредактировать файл конфигурации MySQL:
 
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

Добавить параметры:

[mysqld]
server-id = 1
relay-log = /var/log/mysql/mysql-relay-bin.log
log_bin = /var/log/mysql/mysql-bin.log
binlog_format = ROW
binlog_do_db = test_replication
bind-address            = 0.0.0.0
mysqlx-bind-address     = 0.0.0.0
![master_sql](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/Screenshot%20from%202025-01-19%2019-35-02.png)

Перезапустите MySQL:
sudo systemctl restart mysql

Создать пользователя для репликации: 
Войдите в MySQL:

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
bind-address            = 0.0.0.0
mysqlx-bind-address     = 0.0.0.0
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/Screenshot-23.png)
Перезапустить MySQL:

sudo systemctl restart mysql

Настроить репликацию: 

Войти в MySQL на втором сервере:
 
mysql -u root -p

CHANGE MASTER TO
MASTER_HOST='172.31.42.194',
MASTER_USER='replica_user',
MASTER_PASSWORD='1q2w3e4r5t',
MASTER_LOG_FILE='mysql-bin.000012',  -- Значение из Master
MASTER_LOG_POS=604;                 -- Значение из Master
START SLAVE;
SHOW SLAVE STATUS\G;
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/replica_SHOW_SLAVE_STATUS_G.png)

Result:
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/master_CreateTable7.png)
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/Master_Test_table.png)
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/replica_DB_test.png)

 
Шаг 3: НДля настройки отказоустойчивости MySQL с использованием Keepalived и виртуальных IP-адресов (VIP), чтобы обеспечить высокую доступность и автоматическое переключение между мастер-сервером и репликой, можно использовать следующую схему:

Шаги для настройки отказоустойчивости с Keepalived:
1. Установите Keepalived на обеих машинах (Master и Replica)
На обоих серверах (Master и Replica) нужно установить Keepalived.


sudo apt-get update
sudo apt-get install keepalived
2. Настройка конфигурации Keepalived
На Master сервере:
Откройте файл конфигурации Keepalived:

 
sudo nano /etc/keepalived/keepalived.conf
Добавьте следующую конфигурацию для Master:

 
vrrp_instance VI_1 {
    state MASTER
    interface enX0          # Укажите ваш интерфейс, на котором будет работать VIP
    virtual_router_id 51    # Уникальный идентификатор VRRP
    priority 101            # Приоритет для мастера (100 - для реплики)
    advert_int 1            # Интервал для отправки пакетов VRRP (по умолчанию 1 сек)
    virtual_ipaddress {
        192.168.0.100       # Виртуальный IP, который будет использоваться для подключения
    }
}
Сохраните и закройте файл.

На Replica сервере:
Откройте файл конфигурации Keepalived:

 
sudo nano /etc/keepalived/keepalived.conf
Добавьте следующую конфигурацию для Replica:

 
vrrp_instance VI_1 {
    state BACKUP
    interface enX0          # Укажите ваш интерфейс, на котором будет работать VIP
    virtual_router_id 51    # Уникальный идентификатор VRRP
    priority 100            # Приоритет для реплики (менее приоритетный, чем у мастера)
    advert_int 1            # Интервал для отправки пакетов VRRP (по умолчанию 1 сек)
    virtual_ipaddress {
        192.168.0.100       # Виртуальный IP, который будет использоваться для подключения
    }
}
Сохраните и закройте файл.

3. Запуск и включение Keepalived
После настройки конфигурации на обоих серверах перезапустите службу Keepalived:

На Master сервере:
sudo systemctl restart keepalived

На Replica сервере:

sudo systemctl restart keepalived
Убедитесь, что Keepalived запускается без ошибок:

 
sudo systemctl status keepalived

4. Настройка MySQL
Убедитесь, что на Master сервере MySQL настроена репликация с Replica сервером, и данные синхронизируются между ними.

Проверьте, что Replica настроена как Slave для Master:

На Master:

SHOW MASTER STATUS;
На Replica:
 
SHOW SLAVE STATUS\G;

5. Проверка отказоустойчивости
После настройки и запуска Keepalived, создается виртуальный IP, который будет использоваться для доступа к MySQL-серверу. Этот IP будет "плавно" переключаться между Master и Replica серверами.

Проверьте, что VIP (например, 192.168.0.100) доступен на обоих серверах:

На Master сервере:

ip a show dev enX0
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/master_ip.png)

На Replica сервере:

ip a show dev enX0
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/Homework18_Database_2/Pictures/replica_ip.png)

Проверьте, что MySQL доступен по виртуальному IP:

На любом сервере:

mysql -u root -p -h 192.168.0.100

Остановите MySQL на Master сервере:
sudo systemctl stop mysql

В это время VIP должен автоматически переключиться на Replica сервер, и MySQL должен быть доступен через этот IP на реплике.

После восстановления Master сервера (запуск MySQL), VIP снова должен вернуться на Master сервер.

6. Автоматическое переключение
Keepalived будет следить за состоянием серверов. Если Master сервер перестанет работать, виртуальный IP будет перенаправлен на Replica сервер. Когда Master сервер восстановится, VIP снова будет привязан к нему.

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
