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


cp -f /aiBot/default /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

cp /aiBot/gunicorn.socket /etc/systemd/system/gunicorn.socket

cp /aiBot/gunicorn.service /etc/systemd/system/gunicorn.service

mv /usr/local/bin/gunicorn /aiBot/env/bin/

service gunicorn start  

service nginx restart

service gunicorn enable