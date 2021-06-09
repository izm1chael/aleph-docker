#!/bin/bash

runuser -u elasticsearch ./usr/share/elasticsearch/bin/elasticsearch -d -p pid
python /opt/aleph/bin/aleph-server.py
python /opt/aleph/bin/db_create.py
python /opt/aleph/bin/aleph-webui.sh