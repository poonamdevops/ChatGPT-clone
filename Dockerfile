FROM python:3.10

RUN apt-get update && apt-get install -y \
    nginx

WORKDIR /aiBot

COPY . /aiBot/

RUN pip install -r requirements.txt

RUN chmod +x envSetup.sh

RUN ./envSetup.sh

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD service nginx start && python3 /aiBot/manage.py runserver 0.0.0.0:8000
