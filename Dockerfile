FROM openjdk:11-jre-alpine as java
FROM python:3.8-alpine

# Copy Java from the java image
COPY --from=java /usr/lib/jvm/java-11-openjdk /usr/lib/jvm/java-11-openjdk

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV PATH $PATH:$JAVA_HOME/bin

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install build dependencies, install Python packages, then remove build dependencies
COPY requirements.txt /requirements.txt
RUN apk add --no-cache --virtual .build-deps gcc musl-dev && \
    pip install --no-cache-dir -r /requirements.txt && \
    apk del .build-deps

# Verify Java installation
RUN java -version

# Download and set up HanLP models
RUN python -c "from pyhanlp import *; HanLP.segment('测试一下')"

# Copy the main.py file into the container
COPY main.py /app/main.py

# Set the working directory
WORKDIR /app

# Run the main.py script when the container launches
CMD ["python", "main.py"]
