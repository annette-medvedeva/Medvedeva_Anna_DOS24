Задание 2 – развертывание приложения с помощью Docker-compose
Шаги, которые необходимо выполнить:
1. Создайте новый файл docker-compose.yml в пустой директории на
вашем локальном компьютере.
2. Напишите инструкцию version в версии 3.
3. Определите сервис для базы данных PostgreSQL. Назовите его "db".
Используйте образ postgres:latest, задайте переменные окружения
POSTGRES_USER, POSTGRES_PASSWORD и POSTGRES_DB для
установки пользовательского имени, пароля и имени базы данных
соответственно.
4. Определите сервис для веб-сервера на основе образа NGINX. Назовите
его "web". Используйте образ nginx:latest. Определите порт, на котором
должен работать сервер, с помощью инструкции ports. Задайте путь к
файлам конфигурации NGINX внутри контейнера, используя
инструкцию volumes.
5.* Определите ссылку на сервис базы данных в сервисе веб-сервера.
Используйте инструкцию links.
6. Сохраните файл docker-compose.yml и запустите приложение с
помощью команды docker-compose up.
7. Проверьте, что приложение работает, перейдя в браузере на
localhost:80.


Создайть файл docker-compose.yml

Структура проекта:
Copy
project/
├── docker-compose.yml
├── nginx/
│   └── conf.d/
│       └── default.conf
└── static/
    └── index.html
└──.env
└── Dockerfile  

 Добавить конфигурацию Nginx (nginx/conf.d/default.conf)

 Создайть файлы:
mkdir -p nginx/conf.d static
touch nginx/conf.d/default.conf static/index.html
Наполнить static/index.html любым HTML-контентом 
Запустите приложение:

docker-compose --env-file .env up -d
роверьте работу:

Откройте в браузере: http://localhost:80

Проверьте статус контейнеров:

docker-compose ps
Проверка связи между сервисами:
Чтобы убедиться, что веб-сервер "видит" базу данных

docker exec -it nginx_web ping db