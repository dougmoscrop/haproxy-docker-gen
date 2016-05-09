#!/bin/bash

set -eu

COMPOSE_URL=https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m`

# Install docker-compose
echo "Downoading $COMPOSE_URL"
curl -sS -L $COMPOSE_URL > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
