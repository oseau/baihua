FROM openjdk:slim as java
FROM python:3.8-bookworm

COPY --from=java /usr/lib/jvm /usr/lib/jvm

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
