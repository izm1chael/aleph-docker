FROM ubuntu:16.04

LABEL maintainer="m.johnson@cyber-bytes.co.uk"
ARG BUILD_DATE=(date +'%Y-%m-%d')
LABEL org.label-schema.build-date=$BUILD_DATE

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH=$PATH:/opt/elasticsearch-6.8.16/bin


# Install all dependencies 
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python-pyrex \
    libffi-dev \
    libfuzzy-dev \
    python-dateutil \
    libsqlite3-dev \
    wget \
    git \
    python-pip \
    ssdeep \
    python-dev \
    libffi-dev \
    libfuzzy2 \
    curl \
    apt-transport-https \
    openjdk-8-jdk \
    unzip    

#Install Elasticsearch
RUN export JAVA_HOME
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb && \
    dpkg -i elasticsearch-2.3.1.deb
ADD /config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
ADD /config/logging.yml  /usr/share/elasticsearch/config/logging.yml
RUN mkdir -p /usr/share/elasticsearch/config/scripts
RUN mkdir -p /usr/share/elasticsearch/logs
RUN mkdir -p /usr/share/elasticsearch/data
RUN mkdir -p /usr/share/elasticsearch/data/aleph-cluster
RUN chmod -R 777 /usr/share/elasticsearch

#Clone and configure Aleph
USER root
WORKDIR /opt
RUN git clone https://github.com/merces/aleph.git
RUN sed -i "/bitstring==3.1.3/c bitstring==3.1.4" aleph/requirements.txt
RUN sed -i "/pefile==1.2.10-114/c pefile==2016.3.28" aleph/requirements.txt
RUN sed -i "/elasticsearch==1.2.0/c elasticsearch==6.8.2" aleph/requirements.txt
RUN cd aleph && \
    pip install -U pip==20.2.4 && \
    pip install cffi && \
    pip install -r requirements.txt
RUN mkdir -p /opt/aleph/temp
RUN mkdir -p /opt/aleph/samples
RUN mkdir -p /opt/aleph/unprocessed_samples
COPY /config/settings.py /opt/aleph/aleph/settings.py

EXPOSE 5000
HEALTHCHECK CMD curl --fail http://localhost:5000 || exit 1   

VOLUME /opt/aleph/samples /opt/aleph/unprocessed_samples

RUN mkdir /opt/scripts/
ADD /scripts/run.sh /opt/scripts/run.sh
RUN chmod +x /opt/aleph/bin/aleph-server.py
RUN chmod +x /opt/aleph/bin/db_create.py
RUN chmod +x /opt/aleph/bin/aleph-webui.sh

WORKDIR /opt/scripts
CMD ["/bin/bash", "/opt/scripts/run.sh"]