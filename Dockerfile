FROM python:3.10-alpine

WORKDIR /aiBot

COPY . /aiBot/

# RUN apt-get update && apt-get install -y supervisor python3-pip python3-dev nginx

# RUN chmod +x envSetup.sh && \
#     ./envSetup.sh

RUN apk update && \
    apk add supervisor python3-dev nginx && \
    chmod +x envSetup.sh && \
    /aiBot/envSetup.sh && \
    rm -rf /var/cache/apk/*

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=django_chatbot.settings

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
