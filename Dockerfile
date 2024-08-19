FROM openjdk:11-jre-slim as java
FROM python:3.8-slim

# Copy Java from the java image
COPY --from=java /usr/local/openjdk-11 /usr/local/openjdk-11

ENV JAVA_HOME /usr/local/openjdk-11
ENV PATH $PATH:$JAVA_HOME/bin

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install build dependencies, install Python packages, then remove build dependencies
COPY requirements.txt /requirements.txt
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libc6-dev && \
    pip install --no-cache-dir -r /requirements.txt && \
    apt-get purge -y --auto-remove gcc libc6-dev && \
    rm -rf /var/lib/apt/lists/*

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
