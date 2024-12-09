#!/bin/bash

# Путь к лог-файлу
LOGFILE="/home/anna/Downloads/Medvedeva_Anna_DOS24/HomeWork12_Script2/server.log"

# Проверка существования лог-файла
if [[ ! -f "$LOGFILE" ]]; then
  echo "Лог-файл $LOGFILE не найден. Пожалуйста, создайте его перед запуском."
  exit 1
fi

# Извлечение IP-адресов с успешным статусом (200)
echo "Successful logins (IP addresses):"
grep "status=200" "$LOGFILE" | sed -n 's/.*ip=\([0-9\.]*\) status=200/\1/p' | sort | uniq

# Извлечение уникальных пользователей с ошибочным статусом (403)
echo "Users with failed logins:"
grep "status=403" "$LOGFILE" | sed -n 's/.*user=\([^ ]*\) ip=.*status=403/\1/p' | sort | uniq
