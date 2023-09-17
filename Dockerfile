FROM python:3.10

# Install nginx
RUN apt-get update && apt-get install nginx -y

# Create a directory for your Django app
WORKDIR /aiBot

# Copy your Django application code and requirements

COPY . /aiBot/

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port 8000 for Django
EXPOSE 8000

# Start Django and nginx within the container
CMD service nginx start && nohup python3 /aiBot/manage.py runserver 0.0.0.0:8000 &
