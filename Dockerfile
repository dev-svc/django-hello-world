FROM python:3.6.4-alpine3.7


ENV APP_HOME=/microservice/

RUN mkdir $APP_HOME && adduser -S -D -H python && chown -R python $APP_HOME
WORKDIR $APP_HOME

ADD requirements.txt $APP_HOME
RUN pip install --upgrade pip && pip install -r requirements.txt

ADD . $APP_HOME

EXPOSE 8080
USER python

# CMD ["gunicorn", "--worker-class", "eventlet", "--workers", "1", "--log-level", "INFO", "--bind", "0.0.0.0:8080", "manage:app"]
ENTRYPOINT ["python", "manage.py"]
