Нужно будет создать скрипт, который очищает кэш apt, и добавить его в cron, чтобы он выполнялся раз в месяц в указанное время. Вот пошаговая инструкция:

Шаг 1: Создайте скрипт
Откройте терминал.

Создайте новый файл скрипта. Например, вы можете назвать его clear_apt_cache.sh:

vim ~/clear_apt_cache.sh
Вставьте следующий код в файл:

#!/bin/bash
# Очищаем кэш apt
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove

Чтобы сохранить файл и выйти, нажать Esc, затем ввести :wq и нажмите Enter.

Сделать скрипт исполняемым:

chmod +x ~/clear_apt_cache.sh

Шаг 2: Добавить задание в cron
Открыть vim редактор crontab для редактирования:

crontab -e
В конце файла добавьте следующую строку, чтобы запланировать выполнение скрипта 1-го числа каждого месяца в 16:00:

0 16 1 * * /bin/bash ~/clear_apt_cache.sh
Эта запись означает:

0 — минуты (0 минут)
16 — часы (16:00)
1 — день месяца (1-е число)
* — месяц (любой)
* — день недели (любой)
Сохраните файл и закройте редактор.

Шаг 3: Проверьте настройки cron
Убедиться, что задание добавлено:
crontab -l
увидеть запись в списке задач.
![Script_apt_clear](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork5/HomeWork5/Pictures/Result_script5.png)
Теперь  скрипт будет автоматически выполняться раз в месяц в 16:00 и очищать кэш apt.

 Решение задачи 2.
 1) Создайть Node.js приложение - сохранить myapp.js

const http = require('http');
// Get MYAPP_PORT from environment variable
const MYAPP_PORT = process.env.MYAPP_PORT || 3000; // Установите значение по умолчанию на 3000
http.createServer((req, res) => {
    if (req.url === '/kill') {
        // App die on uncaught error and print stack trace to stderr
        throw new Error('Someone kills me');
    }
    if (req.method === 'POST') {
        // App print this message to stderr, but is still alive
        console.error(`Error: Request ${req.method} ${req.url}`);
        res.writeHead(405, { 'Content-Type': 'text/plain' });
        res.end('405 Method Not Allowed');
        return;
    }
    // App print this message to stdout
    console.log(`Request ${req.method} ${req.url}`);
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('200 OK');
}).listen(MYAPP_PORT);

console.log(`Server running at http://localhost:${MYAPP_PORT}/`);

2) Установить Node.js
sudo apt update
sudo apt install -y curl software-properties-common
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

проверить установку
node -v
npm -v

3) Создать конфигурационный файл в каталоге /etc/systemd/system/.  например, myapp.service.
sudo nano /etc/systemd/system/myapp.service
Содержимое этого файла должно выглядеть так:

[Unit]
Description=My Node.js App
After=network.target

[Service]
ExecStart=/usr/bin/node /home/anna/Downloads/Medvedeva_Anna_DOS24/HomeWork5/Task2_Service/myapp.js
Environment="MYAPP_PORT=3000"
Restart=always
User=anna
WorkingDirectory=/home/anna/Downloads/Medvedeva_Anna_DOS24/HomeWork5/Task2_Service
StandardOuput=syslog
StandardError=syslog
SyslogIndentifier =myapp

4) Перезагрузить конфигурацию и сервис:

После внесения изменений выполните следующие команды:

sudo systemctl daemon-reload
sudo systemctl restart myapp
sudo systemctl status myapp
![Status](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork5/HomeWork5/Pictures/systemd_status.png)

4) Проверка работы приложения
curl http://localhost:3000/
![curl_http](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork5/HomeWork5/Pictures/curr_localhost3000.png)

journalctl -u myapp.service
![journalctl](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork5/HomeWork5/Pictures/journalctl.png)

5) Чтобы настроить syslog
   
Отключите подавление повторяющихся сообщений: Добавьте следующую строку в файл конфигурации /etc/rsyslog.conf или в отдельный файл конфигурации rsyslog (например, /etc/rsyslog.d/myapp.conf):

$RepeatedMsgReduction off

Это отключит сведение повторяющихся сообщений в один блок.

Настройте правила для логирования: Добавьте в файл /etc/rsyslog.conf или /etc/rsyslog.d/myapp.conf правила для записи сообщений от myapp в отдельные файлы в зависимости от уровня серьезности:

if $programname == 'myapp' and $syslogseverity < 5 then -/var/log/myapp/error.log

if $programname == 'myapp' and $syslogseverity >= 5 then -/var/log/myapp/debug.log

Здесь:

syslogseverity < 5 направляет сообщения уровней "err" и выше (более серьезные) в error.log.

syslogseverity >= 5 направляет менее критичные сообщения (например, "notice" и "info") в debug.log.

Перезапустите rsyslog для применения изменений: sudo systemctl restart rsyslog

Чтобы просмотреть логи, которые были настроены для записи в файлы /var/log/myapp/error.log и /var/log/myapp/debug.log, используйте одну из следующих команд:


Просмотр последних строк файла: tail -f /var/log/myapp/error.log

tail -f /var/log/myapp/debug.log
