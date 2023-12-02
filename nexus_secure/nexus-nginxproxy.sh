#!/bin/bash

set +x

# Create certs directory
if [ -d certs ]; then
  echo "Directory 'certs' already exists. Clearing it...Now!"
  rm -r certs
  echo "Creating a fresh cert dir"
  mkdir certs
else
  mkdir certs
  echo "Directory 'certs' created."
  ls
fi

# Generate Root Key rootCA.key with 2048
openssl genrsa -passout pass:"$1" -des3 -out certs/rootCA.key 2048

# Generate Root PEM (rootCA.pem) with 1024 days validity.
openssl req -passin pass:"$1" -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=Local Certificate"  -x509 -new -nodes -key certs/rootCA.key -sha256 -days 1024 -out certs/rootCA.pem

# Add root cert as trusted cert
apt-get install -y ca-certificates
cp certs/rootCA.pem /etc/ssl/certs/
update-ca-certificates # for debian-based (ubuntu)

# Generate nexus Cert
openssl req -subj "/C=US/ST=Random/L=Random/O=Global Security/OU=IT Department/CN=localhost"  -new -sha256 -nodes -out certs/nexus.csr -newkey rsa:2048 -keyout certs/nexuskey.pem
openssl x509 -req -passin pass:"$1" -in certs/nexus.csr -CA certs/rootCA.pem -CAkey certs/rootCA.key -CAcreateserial -out certs/nexuscert.crt -days 500 -sha256 -extfile <(printf "subjectAltName=DNS:localhost,DNS:nexus-repo")

# cd ../nginx/
cd certs
echo $PWD
echo "I think that's it"

# cd ..
# echo $PWD

# Making Build Context for Dockerfile from certs dir
cp nexuscert.crt ../nexus_secure/nexuscert.crt
cp nexuskey.pem ../nexus_secure/nexuskey.pem

cd ../nexus_secure
echo $PWD
# Docker build nginx image
docker build --no-cache -t nginx-nexushttps .

# cd ../
# echo $PWD

# Run nginx and nexus containers
docker-compose up -d