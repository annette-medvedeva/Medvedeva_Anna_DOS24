import os
import platform
import subprocess

# Функция для выполнения ping-запроса
def ping(ip):
    # Для Windows используется 'ping -n', для Linux/Mac - 'ping -c'
    command = ['ping', '-n', '1', ip] if platform.system().lower() == 'windows' else ['ping', '-c', '1', ip]
    try:
        # Выполнение команды ping
        response = subprocess.check_call(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True  # Если пинг успешен
    except subprocess.CalledProcessError:
        return False  # Если пинг не прошел

# Основная функция
def check_ips(ip_list):
    results = []

    for ip in ip_list:
        status = 'reachable' if ping(ip) else 'unreachable'
        results.append(f"{ip}: {status}")

    # Сохранение результатов в файл
    with open('ping_results.txt', 'w') as file:
        for result in results:
            file.write(result + '\n')

# Пример списка IP-адресов
ip_addresses = ['192.168.1.1', '8.8.8.8', '10.0.0.1']

# Вызов основной функции
check_ips(ip_addresses)

print("Результаты проверки сохранены в файл 'ping_results.txt'.")
