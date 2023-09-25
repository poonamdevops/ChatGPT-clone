FROM python:3.10

WORKDIR /aiBot

COPY . /aiBot/

RUN apt-get update && apt-get install -y supervisor python3-pip python3-dev nginx

RUN chmod +x envSetup.sh && \
    ./envSetup.sh

EXPOSE 80

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/gunicorn /var/log/nginx

RUN chown -R www-data:www-data /var/log/gunicorn /var/log/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]


