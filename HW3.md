1. Создайте 2 виртаульных машины (далее - VM1, VM2. Вы можете дать любое удобное вам название). Используйте образ ubuntu24.10
2. Пройдите польностью все этапы установки и вручную разбейте свободное пространство на диски.
3. Настройте SSH-соеденение следующим образом: хостовая ОС -> VM1, VM1 -> хостовая ос, VM2 -> VM1, VM2 -x> хостовая ОС. Запрет соеденения можно осуществить любым удобной полиси через iptables.

* с помощью инструмента Hashicorp Packer создайте образы двух виртуальных машин с заранее подготовленными предустановками, описанными выше. Должно быть 2 конфига.

Выполнение:
Настройка SSH-соединения
Для настройки SSH-соединения между хостовой ОС, VM1 и VM2:

Шаг 1: Установить SSH на обеих виртуальных машинах
На VM1 (MacOs) и VM2(Ubuntu) установить SSH-сервер:

sudo apt update
sudo apt install openssh-server
Шаг 2: Настройка подключения VM1 -> хост и VM2 -> VM1

Подключение VM2 к VM1:
Найди IP-адрес VM1 внутри сети VirtualBox
ip addr show

Запусти SSH-соединение с VM2:
ssh User@IP
ssh osboxes@192.168.8.8


Шаг 3: Запрет подключения VM2 к хостовой ОС
Запретить SSH-соединение с VM2 на хостовую ОС можно через iptables.

На хостовой ОС добавить правило в iptables, которое блокирует подключения с VM2:

sudo iptables -A INPUT -s 192.168.8.6 -j REJECT

Проверить 
sudo iptables -L -v -n



4. Создание образов с помощью HashiCorp Packer  для VM1(Linux)

sudo apt update
sudo apt install packer

Шаги для создания образа с Packer
Шаг 1: Создайте Packer-конфигурационные файлы для VM1 
Создайте директорию для проекта и перейдите в неё:
mkdir packer_ubuntu_images
cd packer_ubuntu_images

Шаг 2: Установите плагин virtualbox для Packer
Перейдите в каталог, где Packer хранит плагины:
mkdir -p ~/.config/packer/plugins
cd ~/.config/packer/plugins
packer plugin install github.com/hashicorp/virtualbox

Создать Packer-файл для VM1:

Создать файл vm1.pkr.hcl

nano vm1.pkr.hcl

{
  "builders": [{
    "type": "virtualbox-iso",
    "vm_name": "VM1",
    "iso_url": "/home/anna/Downloads/ubuntu-24.04.1-live-server-amd64.iso",
    "iso_checksum": "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9",
    "iso_checksum_type": "sha256",
    "ssh_username": "packer",
    "ssh_password": "packer_password",
    "ssh_wait_timeout": "30m",
    "shutdown_command": "echo 'packer_password' | sudo -S shutdown -P now",
    "disk_size": 20480,
    "guest_os_type": "Ubuntu_64",
    "http_directory": "http",
    "boot_wait": "10s",
    "boot_command": [
      "<esc><wait>",
      "install<wait>",
      "<enter><wait>"
    ]
  }]
}


packer init -upgrade /home/user/packer_ubuntu_images/vm1.json

packer build vm1.pkr.hcl
