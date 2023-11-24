# Local server

## Table of contents
	
* [Туториал по созданию и настройке локального сервера](#)
	* [Инструкция по начальной настройке Ubuntu](#local_server_setup)
	* [Установка и настройка Python](#python_setup)
		* [Установка Flask в вирутальную среду](#flask_setup)
		* [Простейшее Flask приложение](#simple_flask)
	* [Установка и настройка Docker](#docker_setup)


<a id="local_server_setup"></a>
### Инструкция по начальной настройке Ubuntu
В данной инструкции постараюсь описать шаги, которые я делаю, для зодания инфраструктуры для моего pet проекта.

#### 1. [Скачиваем VirtualBox с официального сайта](https://www.virtualbox.org/wiki/Downloads)

Ткнул в windows hosts

#### 2. [Скачаем убунту сервер](https://ubuntu.com/download/server)

Скачал версию 20.04

#### 3. Запускаем VirtualBox.

	Ставится автоматически, просто прокликали next.
	Запустили, переходим во вкладку "файл" -> "менеджер сетей хоста"
	Должно открыться окошко, где будут 
	Virtual-Box Host-Only Ethernet Adapter 192.168.56.1/24
	Галочку с "DHCP server" убираем 
	Если покликать по названию выскочит: IPv4 192.168.56.1
	Маска подсети: 255.255.255.0
	
	Жмем создать. Вибираем 
		
#### 4. При попытке запуска падает с ошибкой:

```
Failed to open/create the internal network 'HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter' (VERR_INTNET_FLT_IF_NOT_FOUND).
Failed to attach the network LUN (VERR_INTNET_FLT_IF_NOT_FOUND).
Код ошибки: 
E_FAIL (0x80004005)
Компонент: 
ConsoleWrap
Интерфейс: 
IConsole {872da645-4a9b-1727-bee2-5585105b9eed}
```

	Полез в настройки:
	Device Manager -> Network Adapters -> Virtual Box Host-Only Ethernet Adapter ->  Driver -> update driver

	Вроде всё работает)

#### 5. Запускаем установку ubuntu 20.04 LT Server

	Везде кликаем done
	Когда предложит установить ли ssh выбираем да, и жмем done
	Во всплывающем окошке continue 
	Заполняем пароль итд
	Надо будет отключить привод когда система попросить рестарта 


#### 6. Настройка пароля для sudo:
	
```bash
:/$ sudo passwd
```

	Потом трижды вводим: СамыйСекретныйПароль
	Ну или какой-то другой секретный пароль

#### 7. Надо раскоментить строку в файле sshd_config и заменить значение:
```bash
sudo nano /etc/ssh/sshd_config
```
	
	Было:
```	
#PermitRootLogin prohibit-password
```

	Стало:
```
PermitRootLogin yes
```
	
Ctrl + X -> Yes -> Enter

#### 8. 
Запускаем команду:
```bash
:/$ ifconfig 
```
или
```bash
:/$ ip address
```

	Здесь мы видим, что есть три интерфейса: 
	
- lo — локальная петля, 
- enp0s3 — это «Адаптер 1» который у нас настроен как NAT (через него идет интернет-трафик в Ubuntu) 
- enp0s8 — это и есть вышеупомянутый «Адаптер 2» («Виртуальный адаптер хоста»). Теперь осталось его настроить.
	
	Если ifconfig не установлен (считается старой технологией, в новых версиях установлен ip)

```bash
sudo apt install net-tools

ifcongig enp0s8

sudo ifcongig enp0s8 192.168.56.101
```	
		Ссылка почитать:
		https://habr.com/ru/post/324016/?ysclid=l8k2zdzhm354537489

	Можно ifconfig заменить на ip address ... но что точно не выяснил пока
	ifcongig устаревшая технология, сейчас надо использовать ip

#### 9. Перезапускаем ssh:
```bash
sudo service ssh restart
```

#### 10. Теперь можем коннектиться через winscp:
- Открываем winscp
- Создаем новое подключение
- host: тот, что указали рание в команде ifconfig: *192.168.56.101*
- port: 22
- user: тот который указали при устновке Ubuntu
- passwd: тот самый сверх секретный пароль




<a id="python_setup"></a>
### Установка и настройка Python

1. Для начала я бы проверил версию python на тачке, с которой предстоит работать:
	:/$ python3 --version
	
	Если питон установлен, то появится сообщение с версией, если же нет, то как бы и не очень то хотелось, устанавливаем:
	:/$ sudo apt install python3
	
	
2. теперь проверим есть ли pip:
	Немного костыльный способ, но всё же:
	:/$ python3-pip freeze | grep json
	
	

3.	Устанавливаем python
```
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools
```

	Система однократно спросит, хочу ли я продолжить, а потом выскочит всплывающее окошко на фоне цвета фуксии и предложит ребутнуть несколько сервисов
	Табом переходишь на кнопку ок и энтр


<a id="flask_setup"></a>
#### Установка Flask в вирутальную среду
```
sudo apt install python3-venv

mkdir ~/myproject

cd myproject
```

Создайте виртуальную среду для хранения требований Python для вашего проекта Flask, введя следующую команду:
python3 -m venv myvenv
Локальные копии Python и pip будут установлены в каталог myvenv в каталоге вашего проекта. Прежде чем устанавливать приложения в виртуальной среде, ее нужно активировать. Для этого нужно ввести следующую команду:
source myvenv/bin/activate
Командная строка изменится, показывая, что теперь вы работаете в виртуальной среде. Она будет выглядеть примерно так: (myvenv)user@host:~/myproject$

Для деактивации надо набрать: deactivate

1.3 Загрузка Flask
Вначале мы установим wheel с локальным экземпляром pip, чтобы убедиться, что наши пакеты будут устанавливаться даже при отсутствии архивов wheel:
pip install wheel
И установим Flask в нашей виртуальной среде:
pip install flask

<a id="simple_flask"></a>
#### Простейшее Flask приложение
1. Самое простое приложение на Flask

```python
	from flask import Flask
	app = Flask(__name__)

	@app.route("/")
	def hello():
		return "<h1 color='green'>Hello World!</h1>"

	if __name__ == "__main__":
		app.run(host='0.0.0.0')
```	

<a id="docker_setup"></a>
### Установка и настройка Docker





Dockerfile
#### вариант 1
```
FROM python:3.10.6

COPY . ./webapp

WORKDIR /home/kek/app/
COPY ./etc/requirements.txt /tmp/requirements.txt
RUN pip install --requirement /tmp/requirements.txt

COPY ./webapp/webservice.py /tmp/

EXPOSE 5000


CMD ["python3", "/tmp/webservice.py"]
```


#### вариант 2
```
FROM python

RUN mkdir /service
COPY webapp/ /service/webapp/
COPY etc/ /service/etc/
WORKDIR /service/webapp
RUN python -m pip install --upgrade pip
RUN python -m pip install -r /service/etc/requirements.txt

EXPOSE 50000
ENTRYPOINT [ "python", "webservice.py" ]
```