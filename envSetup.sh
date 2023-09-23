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

cp /aiBot/chatbotUtils /etc/nginx/sites-available/chatbotUtils

rm -f /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/chatbotUtils /etc/nginx/sites-enabled/

cat /aiBot/gunicorn.socket /etc/systemd/system/gunicorn.socket

cat /aiBot/gunicorn.service /etc/systemd/system/gunicorn.service

service gunicorn.socket restart

service nginx restart

service gunicorn.socket enable