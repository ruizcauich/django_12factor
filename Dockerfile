FROM python:3.6

# key from django.core.management.utils.get_random_secret_key
ENV DJANGO_12FACTOR_SECRET_KEY=c0^@j#uz65k++dqhwbaby@qhm*$55q@%c*k&22f$+^iu8ykzjp
ENV DJANGO_12FACTOR_DEBUG=True
ENV DJANGO_12FACTOR_DATABASE_URL=sqlite:////app/db.sqlite3
ENV DJANGO_SETTINGS_MODULE=django_12factor.settings
ENV WORKERS=1

COPY . /app/
WORKDIR /app/
RUN pip install -r requirements.txt
RUN python manage.py migrate

EXPOSE 8000
CMD gunicorn django_12factor.wsgi --bind 0:8000 --workers=$WORKERS
