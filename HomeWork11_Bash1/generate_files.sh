#!/bin/bash

base_directory="./test_directory"

# Создаем основной каталог и подкаталоги
mkdir -p "$base_directory/subdir1"
mkdir -p "$base_directory/subdir2"
mkdir -p "$base_directory/subdir3/protected"

# Создаем файлы с содержимым
echo "This is a test file with random data" > "$base_directory/file1.txt"
echo "Another file with important data" > "$base_directory/subdir1/file2.txt"
echo "Sample file with example text" > "$base_directory/subdir2/file3.txt"
echo "The string to search is here" > "$base_directory/subdir3/file4.txt"

# Создаем файл с правами, ограничивающими доступ
echo "This file is restricted" > "$base_directory/subdir3/protected/restricted.txt"
chmod 000 "$base_directory/subdir3/protected/restricted.txt"

# Выводим сообщение об успешной генерации файлов
echo "Файлы и каталоги успешно созданы в $base_directory"
