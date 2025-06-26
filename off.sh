#!/usr/bin/bash

HOST='bykimott'
YAML_FILE="/home/$HOST/docker-compose.yml"
CONTAINER_NAME="palworld"

# 서버 재시작
docker-compose -f "${YAML_FILE}" pull
docker-compose -f "${YAML_FILE}" down
