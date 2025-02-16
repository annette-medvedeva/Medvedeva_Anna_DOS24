# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем переменные окружения для предотвращения интерактивных запросов
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем пакеты, устанавливаем Nginx, Curl и создаем директорию
RUN apt-get update && \
    apt-get install -y nginx curl && \
    mkdir -p /app/static && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Копируем конфигурацию Nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Копируем статические файлы
COPY static/ /app/static/

# Открываем порт 8020
EXPOSE 8020

# Запускаем Nginx в foreground режиме
CMD ["nginx", "-g", "daemon off;"]