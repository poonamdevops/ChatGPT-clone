#!/bin/bash

apt-get update

apt-get install python3-pip python3-dev nginx -y

pip3 install virtualenv

cd /aiBot

virtualenv env

source /aiBot/env/bin/activate

pip install gunicorn

pip install -r ./requirements.txt

set -x

python3 /aiBot/manage.py makemigrations
python3 /aiBot/manage.py migrate 

cat /aiBot/RPutils.txt > /etc/nginx/sites-available/chatbot

rm -f /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/chatbot /etc/nginx/sites-enabled/

cat /aiBot/unicornSocket.txt > /etc/systemd/system/gunicorn.socket

cat /aiBot/unicornService.txt > /etc/systemd/system/gunicorn.service

service gunicorn.socket restart

service nginx restart

service gunicorn.socket enable