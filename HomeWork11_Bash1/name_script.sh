#!/bin/bash

# Проверка наличия аргументов
if [ "$#" -ne 2 ]; then
  echo "Использование: $0 <строка_для_поиска> <каталог>"
  exit 1
fi

# Переменные
search_string=$1
directory=$2

# Проверка существования каталога
if [ ! -d "$directory" ]; then
  echo "Ошибка: Каталог '$directory' не существует."
  exit 1
fi

# Поиск строки в файлах каталога и его подкаталогов
find "$directory" -type f 2>/dev/null | while read -r file; do
  if grep -q "$search_string" "$file" 2>/dev/null; then
    file_size=$(stat --printf="%s" "$file" 2>/dev/null)
    if [ $? -eq 0 ]; then
      echo "Файл: $file"
      echo "Размер: $file_size байт"
      echo "----------------------------"
    else
      echo "Ошибка получения размера файла: $file"
    fi
  fi
done

# Сообщение об ошибке доступа к каталогу
find "$directory" -type d 2>&1 | grep 'Permission denied' | while read -r error; do
  echo "Ошибка доступа: ${error##*/}: Недостаточно прав для доступа"
done
