FROM python:3.10

WORKDIR /aiBot

COPY . /aiBot/

RUN chmod +x envSetup.sh && \
    ./envSetup.sh

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD /aiBot/env/bin/gunicorn --bind 0.0.0.0:8000 django_chatbot.wsgi