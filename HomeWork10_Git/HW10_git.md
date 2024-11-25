На соданном аккаунте github.com создать репозиторий и клонировать его себе локально. Настроить себе доступы для того, чтобы можно было пушить изменения в ветки. Init commit может быть и локальный, это на ваше усмотрение. Далее реализовать следующие сценарии
1. Создать 5-10 коммитов. (Пример: создать файлы, поменять их содержимое). Вывести их лог экран, сделать скрин и добавить в отчёт.
2. С помощью reflog перейти к предыдущему коммиту (на ваше усмотрение). Output, screen, report. (Вывести их лог экран, сделать скрин и добавить в отчёт.)
https://youtu.be/XRV9kai-3mc (небольшая помощь, если запутаетесь)
3. Создайте ветку с названием на ваше усмотрение (можно develop). OSR. (Output, screen, report.)
4. Создайте коммит и добавьте туда ещё дополнительные измения (добавьте, например в изменяемый файл точку, пробел и тд) с помощью ammend. OSR.
5. Сделайте коммит в main. Но не делайте git push (это важно!), сделайте изменения локально.
6. Сделайте так, чтобы этот коммит оказался в новой ветке с помощью git reset --hard. OSR
7.  Сделайте изменения в файле локально. Сделайте коммит для этого изменения. OSR
8. Через git checkout отмените изменения в файле через откат по сохранённому хэшу. OSR
9. Начните всё заново (это важно чтобы вы делали локально то, что я указал сделать локально). Можно использовать любой из подходов. OSR
Ваш основной гайд: https://pikabu.ru/story/git_shit_10252570
Оформленный отчёт запушьте на ваш ПРИВАТНЫЙ репозиторий, куда вы меня уже добавили или добавите (кто этого ещё не сделал).

Создание новой ветки:
git checkout -b HomeWork10_Repos

Создание 4 коммитов:
git log --oneline
![git_log]([HomeWork10_Git/Pictures/git_log.png](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/git_log.png))

Перейти к предыдущему коммиту с помощью команды:

git reflog

чтобы увидеть историю изменений HEAD

![git_reflog](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/git_reflog.png)

Выберать коммит, к которому хотите вернуться, например, HEAD@{1} для предыдущего коммита.
Используйте команду git reset для перехода:

git reset --hard HEAD@{1}

Проверка
git log --oneline

Локальный коммит в main без git push:

git checkout main
![git_checkout](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/main.png)
![git_checkout](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/main_output.png)

Сделать изменения и коммит:

echo "Temporary changes" > temp.txt
git add temp.txt
git commit -m "Add temp.txt"

![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/temp-branch2.png)
Перенос коммита в новую ветку:

git branch temp-branch

Сбросить коммит в main:
git reset --hard HEAD~1

Перейти в новую ветку и восстановить коммит:
git checkout temp-branch

Новые изменения в файле и коммит:
echo "Another change" >> file1.txt
git add file1.txt
git commit -m "Update file1.txt with another change"
![](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/temp-branch2.png)
![git_checkout_temp-branch]([HomeWork10_Git/Pictures/Screenshot_11.png](https://github.com/annette-medvedeva/Medvedeva_Anna_DOS24/blob/HomeWork10_Git/HomeWork10_Git/Pictures/Screenshot_11.png))
