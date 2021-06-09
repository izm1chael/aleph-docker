#!/bin/bash

su  -s /bin/bash -c "cd /usr/share/elasticsearch/bin && \
./elasticsearch -d -p pid" -m elasticsearch
echo "elasticsearch has started"
nohup python /opt/aleph/bin/aleph-server.py &
echo "Aleph server has started"
nohup python /opt/aleph/bin/db_create.py
echo "Created Aleph DB"
bash /opt/aleph/bin/aleph-webui.sh
echo "Aleph Webui has started"