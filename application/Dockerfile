FROM python:3

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code/

COPY . /code/

RUN pip install -r requirements.txt
RUN python manage.py migrate
RUN python manage.py loaddata clients.json

ENTRYPOINT python manage.py runserver 0.0.0.0:8000

EXPOSE 8000
