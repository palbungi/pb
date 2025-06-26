#!/usr/bin/bash

HOST='bykimott'
YAML_FILE="/home/$HOST/docker-compose.yml"
CONTAINER_NAME="palworld"

# 10분
docker exec -i ${CONTAINER_NAME} rcon-cli "ShowPlayers"
