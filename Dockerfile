FROM python:3.10

WORKDIR /aiBot

COPY requirements.txt /aiBot/

RUN apt-get install nginx -y

RUN pip install -r requirements.txt

COPY . /aiBot/

EXPOSE 8000

CMD python /aiBot/manage.py runserver 0.0.0.0:8000