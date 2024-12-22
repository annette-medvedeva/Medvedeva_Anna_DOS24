Установка и настройка Nginx для отображения HTML страницы
Установка Nginx: Для начала нужно установить Nginx. Для этого выполните команду:

sudo apt update
sudo apt install nginx
Создание HTML страницы: Создайте простой HTML файл с информацией о фамилии и теме урока. Н
апример, создайте файл /var/www/html/index1.html

Настройка конфигурации Nginx: Чтобы настроить Nginx для отображения страницы по адресу http://tms.by, отредактируйте файл конфигурации:

sudo nano /etc/nginx/sites-available/tms.by


Пример конфигурации:


server {
    listen 80;
    server_name tms.by;
    root /var/www/html;
    index index1.html;
    location / {
        try_files $uri $uri/ =404;
    }
}


Создание символической ссылки: Создайте символическую ссылку на файл конфигурации, чтобы он стал активным:

sudo ln -s /etc/nginx/sites-available/tms.by /etc/nginx/sites-enabled/

Проверка конфигурации и перезапуск Nginx: После настройки конфигурации проверьте синтаксис конфигурационных файлов Nginx:
sudo nginx -t

Если ошибок нет, перезапустите Nginx:

sudo systemctl restart nginx

Настройка DNS: Чтобы сайт был доступен по адресу http://tms.by, нужно добавить соответствующую запись в DNS. Например, если вы используете локальную машину, добавьте запись в файл /etc/hosts:

sudo nano /etc/hosts
Добавьте строку:

127.0.0.1 tms.by

![Task1](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/HomeWork14_Web_Servers/Pictures/nginx.png)

Задание 2: Настройка связки Nginx + Apache (Nginx как reverse proxy)
Установка Apache: Установите Apache на сервер:

sudo apt install apache2
Настройка Nginx как reverse proxy: Откройте конфигурационный файл Nginx для редактирования:

sudo nano /etc/nginx/sites-available/tms.by

Пример конфигурации для Nginx, который будет проксировать запросы к Apache:


server {
    listen 80;
    server_name tms.by;
    location / {
        proxy_pass http://127.0.0.1:8090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/HomeWork14_Web_Servers/Pictures/nginx_proxy.png)
В данном примере, Nginx будет проксировать все запросы к Apache, который будет слушать на порту 8080.

Настройка Apache: Для настройки Apache на прослушивание порта 8090, отредактируйте его конфигурацию:

sudo nano /etc/apache2/ports.conf 

Добавьте строку:

Listen 8090
![apach](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/HomeWork14_Web_Servers/Pictures/apache2.png)
Затем настройте виртуальный хост Apache для работы на порту 8090:

sudo nano /etc/apache2/sites-available/000-default.conf
Измените строку:

<VirtualHost *:8090>

Перезапустите Apache:

sudo systemctl restart apache2

Проверка проксирования: Перезапустите Nginx, чтобы применить изменения:

sudo systemctl restart nginx

Теперь, при обращении к http://tms.by, Nginx будет перенаправлять запросы на Apache, который будет обслуживать их.
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/HomeWork14_Web_Servers/Pictures/proxyApach2.png)
Опционально: Проксирование с учётом URL
Если нужно проксировать трафик на разные серверы в зависимости от URL, можно добавить дополнительные location блоки в конфигурацию Nginx:


server {
    listen 80;
    server_name tms.by;
    location /app1/ {
        proxy_pass http://127.0.0.1:8091;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /app2/ {
        proxy_pass http://127.0.0.1:8092;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

В этом примере запросы на http://tms.by/app1/ будут перенаправляться на сервер Apache, который работает на порту 8081, а запросы на http://tms.by/app2/ — на сервер Apache на порту 8082.

После внесения изменений не забудьте перезапустить Nginx:

sudo systemctl restart nginx

![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/main/HomeWork14_Web_Servers/Pictures/nginx_apache2.png)
