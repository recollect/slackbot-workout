#!/bin/bash

# Docker wants paths relative to the host filesystem, not your docker-dev env
HOST_CONFIG="/etc/workout-config.json"
if [[ ! -e $HOST_CONFIG ]]; then
    echo "Couldn't find the config file at: $HOST_CONFIG"
    echo "Maybe you should run this on brew?"
    exit -1;
fi

# Load configs out of the workout-config.json
SLACK_USER_TOKEN_STRING=`perl -MJSON=decode_json -MIO::All -le "print decode_json(scalar io('$HOST_CONFIG')->slurp)->{user_token}"`
SLACK_URL_TOKEN_STRING=`perl -MJSON=decode_json -MIO::All -le "print decode_json(scalar io('$HOST_CONFIG')->slurp)->{url_token}"`


# Spin up a container for the workout bot
CONTAINER="workout-bot"
sudo docker rm -f $CONTAINER
sudo docker run -d -it --name=$CONTAINER \
    -v $HOST_CONFIG:/app/config.json:ro \
    -e SLACK_USER_TOKEN_STRING=${SLACK_USER_TOKEN_STRING} \
    -e SLACK_URL_TOKEN_STRING=${SLACK_URL_TOKEN_STRING} \
    workout
