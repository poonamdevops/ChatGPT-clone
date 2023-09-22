#!/bin/bash
apt-get update

apt-get install python3-pip python3-dev nginx

pip3 install virtualenv

cd /aiBot

virtualenv env

source env/bin/activate

pip install -r requirements.txt

pip install django gunicorn

django-admin startproject textutils /aiBot

python3 /aiBot/manage.py makemigrations
python3 /aiBot/manage.py migrate

ufw allow 8000

gunicorn --bind 0.0.0.0:8000 textutils.wsgi

deactivate

cat /aiBot/unicornSocket.txt > /etc/systemd/system/gunicorn.socket

cat /aiBot/unicornService.txt > /etc/systemd/system/gunicorn.service

systemctl start gunicorn.socket

systemctl enable gunicorn.socket

cat /aiBot/RPutils.txt > /etc/nginx/sites-available/textutils

ln -s /etc/nginx/sites-available/textutils /etc/nginx/sites-enabled/

systemctl restart nginx


