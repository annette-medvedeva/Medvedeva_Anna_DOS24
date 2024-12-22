#!/bin/bash

API_KEY="cb765998fe5264920d8ed1e48118509a"
#curl -s "https://api.openweathermap.org/data/2.5/forecast?lat=50.45&lon=30.523&units=metric&lang=ru&appid=cb765998fe5264920d8ed1e48118509a" | jq ".list[:32]" # 4 дня

# Функция для выполнения запроса к API погоды
fetch_weather_data() {
    local lat="$1"
    local lon="$2"
    local units="$3"
    local lang="$4"

    # Формируем URL для запроса
    local url="https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&units=${units}&lang=${lang}&appid=${API_KEY}"

    # Выполняем запрос
    curl -s "$url"
}

# Функция для обработки и форматирования данных погоды
format_weather_data() {
    local json_data="$1"
    local days="$2"
    echo "$json_data" | jq --argjson days "$days" '
    .list[:$days]
    | map({
        date: .dt_txt | split(" ")[0],
        weather: .weather[0].description,
        temperature: .main.temp,
        humidity: .main.humidity,
        wind_speed: .wind.speed
    })'
}

# Функция отображения меню
show_menu() {
    echo "--------------------------------------"
    echo "На каком языке хотите вывести информацию?"
    echo "1 - русский"
    echo "2 - английский"
    echo "3 - арабский"
    read -p "Введите номер: " lang_choice

    case "$lang_choice" in
        1) lang="ru" ;;
        2) lang="en" ;;
        3) lang="ar" ;;
        *) echo "Неверный выбор языка. Попробуйте снова."; show_menu ;;
    esac

    echo "--------------------------------------"
    echo "Какой город вы хотите посмотреть?"
    echo "1 - Киев"
    echo "2 - Минск"
    echo "3 - Дубай"
    echo "4 - Москва"
    echo "5 - Норильск"
    read -p "Введите номер: " city_choice

    case "$city_choice" in
        1) lat="50.45"; lon="30.523" ;;
        2) lat="53.9"; lon="27.566" ;;
        3) lat="25.276"; lon="55.296" ;;
        4) lat="55.755"; lon="37.617" ;;
        5) lat="69.355"; lon="88.189" ;;
        *) echo "Неверный выбор города. Попробуйте снова."; show_menu ;;
    esac

    echo "--------------------------------------"
    echo "Какая шкала вам нужна?"
    echo "1 - Фаренгейт"
    echo "2 - Цельсий"
    read -p "Введите номер: " unit_choice

    case "$unit_choice" in
        1) temp_unit="F" ;;
        2) temp_unit="C" ;;
        *) echo "Неверный выбор шкалы. Попробуйте снова."; show_menu ;;
    esac

    echo "--------------------------------------"
    echo "На сколько дней показать погоду?"
    echo "1 - 1 (один день)"
    echo "2 - 4 (четыре дня)"
    echo "3 - 5 (пять дней)"
    read -p "Введите номер: " days_choice

    case "$days_choice" in
        1) days=1 ;;
        2) days=4 ;;
        3) days=5 ;; # Максимум API возвращает прогноз на 5 дней
        *) echo "Неверный выбор количества дней. Попробуйте снова."; show_menu ;;
    esac
}

# Основной блок выполнения
main() {
    # Проверяем наличие jq для обработки JSON
    if ! command -v jq &> /dev/null; then
        echo "Установите jq для работы со скриптом (sudo apt install jq)."
        exit 1
    fi

    # Отображаем меню для выбора параметров
    show_menu

    # Преобразуем единицы температуры
    local units=""
    case "$temp_unit" in
        C)
            units="metric"
            ;;
        F)
            units="imperial"
            ;;
        *)
            echo "Неверная единица измерения температуры. Укажите C или F."
            exit 1
            ;;
    esac

    # Получаем данные
    local weather_data
    weather_data=$(fetch_weather_data "$lat" "$lon" "$units" "$lang")

    # Форматируем и выводим данные
    format_weather_data "$weather_data" "$days"
}

# Запуск скрипта
main
