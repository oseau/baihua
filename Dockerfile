FROM openjdk:11-jdk-slim as java
FROM python:3.8-bookworm

COPY --from=java /usr/local/openjdk-11 /usr/local/openjdk-11

ENV JAVA_HOME /usr/local/openjdk-11
ENV PATH $PATH:$JAVA_HOME/bin

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

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
