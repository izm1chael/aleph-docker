# Aleph - OpenSource /Malware Analysis Pipeline System

## What?
Aleph is designed to pipeline the analysis of malware samples. It has a series of collectors that will gather samples from many sources and shove them into the pipeline. The sample manager has a series of plugins that are ran against the sample and returns found data into JSON form.


    docker run -d \
      --name=aleph \
      -p 5000:5000 \
      -p 6881/udp:6881/udp \
      -v /path/to/malware/samples:/opt/aleph/samples \
      -v /path/to/your/unprocessed/samples:/opt/aleph/unprocessed_samples \
      -v /path/to/your/elasticsearch/data:/usr/share/elasticsearch/data
      -v /path/to/your/elasticsearch/config:/usr/share/elasticsearch/config
      --restart unless-stopped \
      izm1chael/aleph



### Docker Compose
```
---
version: "2.1"
services:
  aleph:
    image:  izm1chael/aleph
    container_name: aleph
    volumes:
      - /path/to/malware/samples:/opt/aleph/samples \
      - /path/to/your/unprocessed/samples:/opt/aleph/unprocessed_samples \
      - /path/to/your/elasticsearch/data:/usr/share/elasticsearch/data
      - /path/to/your/elasticsearch/config:/usr/share/elasticsearch/config
    ports:
      - 5000:5000
    restart: unless-stopped
```
