#!/bin/bash

STACK_NAME="csep-seung"

sudo docker stack deploy -c docker-compose.yml -c docker-compose.prod.yml $STACK_NAME