#!/bin/bash

# Путь к лог-файлу
LOGFILE="/home/anna/Downloads/Medvedeva_Anna_DOS24/HomeWork12_Script2/server.log"

# Проверка существования лог-файла
if [[ -f "$LOGFILE" ]]; then
  echo "Файл $LOGFILE уже существует. Переходим к генерации данных."
else
  echo "Файл $LOGFILE не найден. Создаём новый файл."
  touch "$LOGFILE"
fi

# Генерация данных в лог-файл
cat > "$LOGFILE" <<EOL
2024-11-26 12:30:15 [INFO] user=johndoe ip=192.168.1.10 status=200
2024-11-26 12:31:03 [INFO] user=alice ip=10.0.0.5 status=403
2024-11-26 12:35:42 [INFO] user=bob ip=172.16.0.1 status=200
2024-11-26 12:36:00 [INFO] user=johndoe ip=192.168.1.10 status=403
2024-11-26 12:40:22 [INFO] user=charlie ip=10.0.0.8 status=403
2024-11-26 12:42:10 [INFO] user=alice ip=10.0.0.5 status=200
EOL

echo "Данные сгенерированы и записаны в $LOGFILE."