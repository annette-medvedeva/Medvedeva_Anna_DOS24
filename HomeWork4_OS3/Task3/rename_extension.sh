#!/bin/bash

# Проверка на наличие аргументов
if [ $# -ne 2 ]; then
  echo "Usage: $0 <filename> <new_extension>"
  exit 1
fi

# Получение аргументов
original_file="$1"
new_extension="$2"

# Проверка, существует ли файл
if [ ! -f "$original_file" ]; then
  echo "File '$original_file' does not exist."
  exit 1
fi

# Получение базового имени файла без расширения
base_name="$(basename "$original_file" | cut -f 1 -d '.')"

# Формирование нового имени файла с новым расширением
new_file="${base_name}.${new_extension}"

# Копирование файла с новым именем
cp "$original_file" "$new_file"

# Успешное завершение
echo "New file created as '$new_file'"
