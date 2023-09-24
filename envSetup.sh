#!/bin/bash

apt-get update

apt-get install python3-pip python3-dev nginx -y

set -x

pip3 install virtualenv

cd /aiBot

virtualenv env

source /aiBot/env/bin/activate

pip install -r ./requirements.txt

deactivate

#configuring gunicorn as a service 
cp /aiBot/gunicorn.socket /etc/systemd/system/gunicorn.socket

cp /aiBot/gunicorn.service /etc/systemd/system/gunicorn.service

apt-get install systemctl

systemctl start gunicorn.socket 

systemctl enable gunicorn.socket 

#configuring nginx reverse proxy 
cp -f /aiBot/default /etc/nginx/sites-available/default

systemctl daemon-reload

systemctl restart nginx

systemctl enable nginx

systemctl restart gunicorn.socket

