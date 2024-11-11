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
![Script_apt_clear](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork5/Result_script5.png)
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
ExecStart=/usr/bin/node /home/anna/Downloads/Medvedeva_Anna_DOS24/Systemd_task/myapp.js
Environment="MYAPP_PORT=3000"
Restart=always
User=anna
WorkingDirectory=/home/anna/Downloads/Medvedeva_Anna_DOS24/Systemd_task

[Install]
WantedBy=multi-user.target

4) Перезагрузить конфигурацию и сервис:

После внесения изменений выполните следующие команды:

sudo systemctl daemon-reload
sudo systemctl restart myapp
sudo systemctl status myapp

4) Проверка работы приложения
curl http://localhost:3000/

journalctl -u myapp.service

