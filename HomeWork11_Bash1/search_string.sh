#!/bin/bash

# Проверяем наличие всех аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <search_string> <directory>"
    exit 1
fi

search_string="$1"
directory="$2"

# Проверяем существование директории
if [ ! -d "$directory" ]; then
    echo "Каталог $directory не существует."
    exit 1
fi

# Рекурсивный поиск строки
find "$directory" -type f 2>/dev/null | while read -r file; do
    if grep -q "$search_string" "$file" 2>/dev/null; then
        file_size=$(stat --format="%s" "$file" 2>/dev/null || echo "Не удалось получить размер")
        echo "Файл: $file"
        echo "Размер: $file_size байт"
        echo "---------------------------"
    fi
done
