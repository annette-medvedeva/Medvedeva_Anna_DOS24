#!/bin/bash

# Проверка аргументов
if [ "$#" -ne 3 ]; then
    echo "Использование: $0 <output_file> <directory> <extension>"
    exit 1
fi

# Аргументы
output_file=$1
directory=$2
extension=$3

# Проверка существования каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог $directory не существует"
    exit 1
fi

# Поиск файлов и запись в файл
find "$directory" -type f -name "*$extension" > "$output_file"

if [ $? -eq 0 ]; then
    echo "Список файлов записан в $output_file"
else
    echo "Произошла ошибка при записи в $output_file"
    exit 1
fi
