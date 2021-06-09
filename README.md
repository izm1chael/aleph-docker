
# Aleph - OpenSource /Malware Analysis Pipeline System

## What?
Aleph is designed to pipeline the analysis of malware samples. It has a series of collectors that will gather samples from many sources and shove them into the pipeline. The sample manager has a series of plugins that are ran against the sample and returns found data into JSON form.


### Docker CLI

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

### Build Manually

    git clone https://github.com/izm1chael/aleph-docker.git
    cd aleph-docker
    docker build .

You can manage the Aleph configuration file in the /config directory. 

    DEBUG = False
    SAMPLE_SOURCES = [
        ('local', {'path': '/opt/aleph/unprocessed_samples'}),
        #('mail', {'host': 'imap.exampl.com', 'username': 'youruser@example.com', 'password': 'yourpassword', 'root_folder': 'Inbox' })
    ]
    PLUGIN_SETTINGS = {
    #'virustotal': { 'enabled': True, 'api_key': '', 'api_limit': '7' }
    }
    ELASTICSEARCH_URI = '127.0.0.1:9200'
    ELASTICSEARCH_INDEX = 'samples'
    ELASTICSEARCH_TRACE = False
    SAMPLE_TEMP_DIR = '/opt/aleph/temp'
    SAMPLE_STORAGE_DIR = '/opt/aleph/samples'
    SAMPLE_MANAGERS=2 # Simultaneous sample analysis
    SAMPLE_MIN_FILESIZE=40 # bytes
    SAMPLE_MAX_FILESIZE=(1024*1024*30) # bytes
    SECRET_KEY = 'Pu7s0m3cryp7l337here' #do not use this ;)
    SAMPLE_SUBMIT_FOLDER= '/opt/aleph/samples' #where samples will be submitted from webui
    # Mail Options
    MAIL_ENABLE = False
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
    MAIL_USERNAME = 'your-gmail-username'
    MAIL_PASSWORD = 'your-gmail-password'
    MAIL_SENDER = 'Your Name <%s>' % MAIL_USERNAME
    # WebUI Options
    import os
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.path.abspath(os.path.dirname(__file__)), '../webui/db.sqlite' )
    del os
    SERVER_NAME = 'localhost:5000'
    PREFERRED_URL_SCHEME = 'http'
    ALLOW_REGISTRATIONS = True
    SAMPLE_SUBMIT_FOLDER = None
    LOGGING = {
    'directory': 'log/',
    'filename': 'aleph.log',
    'format': '%(asctime)s [%(name)s:%(funcName)s] %(levelname)s: %(message)s',}
    }

