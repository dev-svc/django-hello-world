FROM python
ENV APP_HOME=/microservice/
RUN mkdir $APP_HOME && useradd -ms python
USER python
WORKDIR $APP_HOME
ADD requirements.txt $APP_HOME
RUN pip install --upgrade pip && pip install -r requirements.txt
ADD . $APP_HOME
EXPOSE 8080
# CMD ["gunicorn", "--worker-class", "eventlet", "--workers", "1", "--log-level", "INFO", "--bind", "0.0.0.0:8080", "manage:app"]
ENTRYPOINT ["python", "manage.py"]
