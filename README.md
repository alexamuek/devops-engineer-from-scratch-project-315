# Доска объявлений(Iac)

[![hexlet-check](https://github.com/alexamuek/devops-engineer-from-scratch-project-315/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/alexamuek/devops-engineer-from-scratch-project-315/actions)

Приложение доступно на https://develop-sc.com/

Автоматизация раскатывания контейнеризированного приложения на сервер в облаке

Учебный проект Хекслета: https://ru.hexlet.io/programs/devops-engineer-from-scratch
Как это должно работать: https://asciinema.org/a/v4evn7XjCdou7Yh71IG0ljb0W

## Стек

- Инструменты

## Установка

<!-- Опишите установку: клонирование, зависимости, переменные окружения -->

```bash
git clone https://github.com/alexamuek/devops-engineer-from-scratch-project-315.git
cd devops-engineer-from-scratch-project-315
```

## Использование

<!-- Добавьте примеры запуска и запись asciinema — именно это смотрит работодатель -->

---

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>

## О Хекслете

[Хекслет](https://ru.hexlet.io/) — школа программирования: авторские программы обучения с практикой, поддержкой наставников и реальными проектами, которые остаются в резюме. Этот репозиторий — один из таких проектов.

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

## Подготовка перед деплоем
1. Для работы приложения необходимо иметь заполненные данные в файле /group_vars/servers/vault.xml. Данный файл должен быть зашифрован командой в директории проекта  
```bash
ansible-vault encrypt group_vars/all/vault.yml
```  
2. В хранилище должны быть следующие переменные и ключи:  
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

3. Пароль, который использован во время шифрования, нужно сохранить в корне проекта в файл password. Этот файл не выгружается в удаленный репозиторий.  

4. Перед деплоем приложения нужно установить роли, описанный в requirements.yml командой 
```bash
ansible-galaxy install -r requirements.yml
```  
5. В самом плейбуке plabook-roles.yml нужно обязательно указать свои значения для переменных  
- domain (домен, который будут использовать пользователи, чтобы обратиться к приложению в браузере)  
- image_tag (тэг вашего образа с приложением в docker hub registry)  
6. Если хочется использовать какой-то свой образ с приложением, то нужно во всех тасках и ролях заменить имя образа приложения "alexamuek/project-devops-deploy" на свое значение. Сейчас образ собирается в репозитории https://github.com/alexamuek/project-devops-deploy  

7. Нужно создать s3 storage для проекта. В данном проекте использован сервис https://backblaze.com/.  10 TB памяти бесплатно
Для настройки s3 storage нужно:  
- зарегистрироваться в сервисе  
- создать приватную корзину  
- создать api ключ к этой корзине  
- данные api и корзины добавить в хранилище секретов  


## Работа приложения  
1. У приложения есть контейнер базы postgers  
2. Само приложение запускается в контейнере bulletin-app  
3. Приложение доступно через reverse_proxy nginx  
4. Nginx слушает порт 80 и 443  
5. Настроено кэширование данных средствами nginx  
6. Картинки хранятся в s3 storage  

