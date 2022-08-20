#!/bin/bash

USER=`whoami`
echo "Executing as USER=$USER..."
chown -R hadoop:hadoop /usr/local/hadoop/
chown -R hadoop:hadoop /mnt/hadoop/

CMD="/etc/run.sh $@"
echo "Executing [$CMD]..."
su -s /bin/bash -c "$CMD" hadoop
