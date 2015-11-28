#!/bin/bash

PROJECTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT=${PROJECTPATH##/*/}
#COCOM="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../cocom
DHOME="/home/docker"

#SALT for the hash
SALT="TODO better salt"
# Set the password for the project as a hash of the salt and the project
PASSWORD=`echo $PROJECT $SALT| md5sum | cut -f1 -d" "`

docker run  -it -P -p 80 \
  --rm=false \
  --name $PROJECT \
  --link some-mysql:mysql \
  -e VIRTUAL_HOST=$PROJECT,www.$PROJECT,$PROJECT.localhost,$PROJECT.openco.ca \
  -e COMMAND1="$COMMAND1" \
  -e COMMAND2="$COMMAND2" \
  -v $PROJECTPATH/html/:/usr/share/nginx/html:ro \
  -e DHOME=$DHOME \
  -e PROJECT="${PROJECT//./_}" \
  -e PASSWORD=$PASSWORD \
  -e VIRTUAL_PORT=80 \
  nginx
