Установка gsutil

gsutil входит в состав Google Cloud SDK. Для его установки выполните следующие шаги:
sudo apt update
sudo apt install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update
sudo apt install -y google-cloud-sdk

Проверьте установку
gsutil version

Авторизация
Войдите в свой Google-аккаунт: 
gcloud auth login
Убедитесь, что выбран правильный проект (тот, в котором находится ваш бакет composite-snow-290018):
gcloud config set project composite-snow-290018

Синхронизация файлов
Для синхронизации локальной папки с вашим бакетом выполните команду
gsutil rsync -r /home/anna gs://tms_123121419djscj_test/Medvedeva_Anna
Односторонняя синхронизация (облако → локальная):
gsutil rsync -r gs://tms_123121419djscj_test /home/anna
Двусторонняя синхронизация: Google Cloud Storage не поддерживает встроенную двустороннюю синхронизацию. Однако вы можете выполнить её вручную, запустив две команды:
gsutil rsync -r /home/anna gs://tms_123121419djscj_test
gsutil rsync -r gs://tms_123121419djscj_test /home/anna

Планирование синхронизации:
Откройте редактор для настройки задач:
crontab -e
Строка для автоматической синхронизации (например, раз в час):
0 * * * * gsutil -m rsync -r -e /home/anna gs://tms_123121419djscj_test/Medvedeva_Anna
![gsutil]("https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork8_rsync/HomeWork8_rsync/Pictures/photo_2024-12-01_17-05-46.jpg")
