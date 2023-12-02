#!/bin/bash

rm -r certs

cd nexus_secure

rm -f nexuscert.crt nexuskey.pem

docker-compose down

docker rmi nginx-nexushttps