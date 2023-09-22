#!/bin/bash
apt-get update

apt-get install python3-pip python3-dev nginx

pip3 install virtualenv

cd /aiBot

virtualenv env

source env/bin/activate

pip install django gunicorn

python3 /aiBot/manage.py makemigrations
python3 /aiBot/manage.py migrate

deactivate 

ufw allow 8000

cat /aiBot/unicornSocket.txt > /etc/systemd/system/gunicorn.socket

cat /aiBot/unicornService.txt > /etc/systemd/system/gunicorn.service

service gunicorn.socket start

service gunicorn.socket enable

gunicorn --bind 0.0.0.0:8000 django_chatbot.wsgi

cat /aiBot/RPutils.txt > /etc/nginx/sites-available/chatbot

rm -f etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/chatbot /etc/nginx/sites-enabled/

service nginx restart


