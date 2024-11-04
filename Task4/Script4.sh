#!/bin/bash

# Проверка аргументов
if [ $# -lt 3 ]; then
  echo "Использование: $0 <строка> <начало> <конец> [-d]"
  echo "Параметры:"
  echo "  <строка>  - исходная строка"
  echo "  <начало>  - порядковый номер начального символа подстроки (1-индексация)"
  echo "  <конец>   - порядковый номер конечного символа подстроки (включительно)"
  echo "  -d        - флаг для удаления подстроки вместо выделения"
  exit 1
fi

# Переменные
input_string="$1"
start=$2
end=$3
delete_mode=false

# Проверка флага -d для режима удаления
if [ "$4" == "-d" ]; then
  delete_mode=true
fi

# Обработка подстроки с помощью awk
if $delete_mode; then
  # Удаление подстроки
  awk -v s="$start" -v e="$end" '{print substr($0, 1, s-1) substr($0, e+1)}' <<< "$input_string"
else
  # Извлечение подстроки
  awk -v s="$start" -v e="$end" '{print substr($0, s, e-s+1)}' <<< "$input_string"
fi
