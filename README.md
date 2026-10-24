# Доска объявлений(Iac)

[![hexlet-check](https://github.com/alexamuek/devops-engineer-from-scratch-project-315/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/alexamuek/devops-engineer-from-scratch-project-315/actions)

Приложение доступно на https://develop-sc.com/

Автоматизация раскатывания контейнеризированного приложения на сервер в облаке

Учебный проект Хекслета: https://ru.hexlet.io/programs/devops-engineer-from-scratch
Как это должно работать: https://asciinema.org/a/v4evn7XjCdou7Yh71IG0ljb0W

## Стек

Используемые инструменты и технологии:  
- Ansible  
- Docker  
- Make  
- Postgres  
- Nginx  

## Требования к целевому серверу:

- OC Linux Ubuntu 24.04  

## Требования к хост-машине:
- Ansible 2.17.14  


## Установка

```bash
git clone https://github.com/alexamuek/devops-engineer-from-scratch-project-315.git
cd devops-engineer-from-scratch-project-315
```

1. На хост машине должен быть установлен ansible и make.  
Чтобы их установить, нужно выполнить в консоли:
```bash
sudo apt update  
sudo apt install -y pipx  
pipx ensurepath  
pipx install ansible-core==2.17.14  
sudo apt install -y make  
```
После нужно выполнить проверку установки:  
```bash
ansible --version  
make --version  
```
2. Для работы приложения необходимо иметь заполненные данные в файле /group_vars/servers/vault.xml. Данный файл должен быть зашифрован командой в директории проекта  
```bash
ansible-vault encrypt group_vars/servers/vault.yml
```  
3. В хранилище должны быть следующие переменные и ключи:  
db_user: {пользователь для postgres}  
db_password: {пароль для postgres}  
db_name: {имя базы}  
db_port: {порт postgres}  
storage_keyID: {keyId для s3 storage}  
storage_bucketName: {имя приватной корзиныs3 storage}  
storage_applicationKey: {секретный ключ для s3 storage}  
storage_endpoint: {полный url для подключения по api к s3 storage}  
storage_region: {регион хранения данных s3 storage}  
admin_email: {email для выпуска сертификата}  

4. Пароль, который использован во время шифрования, нужно сохранить в корне проекта в файл password. Этот файл не выгружается в удаленный репозиторий.  

5. Перед деплоем приложения нужно установить роли, описанный в requirements.yml командой
```bash
make install-roles
```  
6. В самом плейбуке plabook.yml нужно обязательно указать свои значения для переменных  
- domain (домен, который будут использовать пользователи, чтобы обратиться к приложению в браузере)  
- image_tag (тэг вашего образа с приложением в docker hub registry)  
7. Если хочется использовать какой-то свой образ с приложением, то нужно во всех тасках и ролях заменить имя образа приложения "alexamuek/project-devops-deploy" на свое значение. Сейчас образ собирается в репозитории https://github.com/alexamuek/project-devops-deploy  

7. Нужно создать s3 storage для проекта. В данном проекте использован сервис https://backblaze.com/.  10 TB памяти бесплатно
Для настройки s3 storage нужно:  
- зарегистрироваться в сервисе  
- создать приватную корзину  
- создать api ключ к этой корзине  
- данные api и корзины добавить в хранилище секретов  

8. Нужно привязать домен к ip сервера, на котором будет развернуто приложение. 

## Использование

Чтобы развернуть приложение, нужно выполнить:  
```bash
make deploy
```  
Чтобы обновить приложение (когда изменился образ), нужно выполнить:
```bash
make update-app
```  
Чтобы перезапустить nginx, нужно выполнить:
```bash
make restart-nginx
```  
Чтобы перезапустить контейнер с базой, нужно выполнить:
```bash
make restart-db
```  

# Работа приложения  
1. У приложения есть контейнер базы postgers  
2. Само приложение запускается в контейнере bulletin-app  
3. Приложение доступно через reverse_proxy nginx  
4. Nginx слушает порт 80 и 443  
5. Настроено кэширование данных средствами nginx  
6. Картинки хранятся в s3 storage 

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>

## О Хекслете

[Хекслет](https://ru.hexlet.io/) — школа программирования: авторские программы обучения с практикой, поддержкой наставников и реальными проектами, которые остаются в резюме. Этот репозиторий — один из таких проектов.
 

