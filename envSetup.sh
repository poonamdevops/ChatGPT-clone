#!/bin/bash

set -x

pip3 install virtualenv

cd /aiBot

python3 -m venv env

source /aiBot/env/bin/activate

python3 manage.py migrate

pip install --no-cache-dir -r ./requirements.txt

cp /aiBot/gunicorn.socket /etc/systemd/system/

cp /aiBot/gunicorn.service /etc/systemd/system/

#configuring nginx reverse proxy 
cp -f /aiBot/default /etc/nginx/sites-available/default

#configuring supervisor to manage gunicorn and nginx services
cp supervisord.conf /etc/supervisor/conf.d/supervisord.conf

mkdir -p /var/log/gunicorn /var/log/nginx /var/log/supervisord

chown -R www-data:www-data /var/log/gunicorn /var/log/nginx /var/log/supervisord