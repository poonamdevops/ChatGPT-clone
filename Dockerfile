FROM python:3.10

WORKDIR /aiBot

COPY . /aiBot/

RUN apt-get update && apt-get install -y python3-pip python3-dev nginx && \
    pip install -r requirements.txt && \
    chmod +x envSetup.sh && \
    ./envSetup.sh

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD /aiBot/env/bin/gunicorn --bind 0.0.0.0:8000 django_chatbot.wsgi