FROM python:3.10

WORKDIR /aiBot

COPY requirements.txt /aiBot/

RUN apt-get update && apt-get install supervisor nginx -y

RUN pip install -r requirements.txt

COPY . /aiBot/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-n"]