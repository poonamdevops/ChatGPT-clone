FROM python:3.10-slim

WORKDIR /aiBot

COPY . /aiBot/

# RUN apt-get update && apt-get install -y supervisor python3-pip python3-dev nginx

# RUN chmod +x envSetup.sh && \
#     ./envSetup.sh

RUN apt-get update && \
    apt-get install supervisor python3-dev nginx -y && \
    chmod +x envSetup.sh && \
    ./envSetup.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
