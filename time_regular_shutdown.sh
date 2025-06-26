#!/usr/bin/bash

HOST='bykimott'
YAML_FILE="/home/$HOST/docker-compose.yml"
CONTAINER_NAME="palworld"

# 10분
docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_10_minutes"

# 5분
sleep 300
docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_5_minutes"
docker exec -i $CONTAINER_NAME rcon-cli save

# 3분
sleep 120
docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_3_minutes"
docker exec -i $CONTAINER_NAME rcon-cli save

# 2분
sleep 60
docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_2_minutes"
docker exec -i $CONTAINER_NAME rcon-cli save

# 1분
sleep 60
docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_60_seconds"

# 10초
sleep 30
docker exec -i $CONTAINER_NAME rcon-cli save

sleep 20

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_10_seconds"

sleep 5

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_5_seconds"

sleep 1

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_4_seconds"

sleep 1

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_3_seconds"

sleep 1

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_2_seconds"

sleep 1

docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_restart_in_1_seconds"

sleep 1

# 서버 종료
docker exec -i $CONTAINER_NAME rcon-cli "Broadcast Server_is_shutting_down_for_maintance"

# 5초 대기
sleep 5

# 서버 재시작
docker-compose -f "${YAML_FILE}" pull
docker-compose -f "${YAML_FILE}" down
docker-compose -f "${YAML_FILE}" up -d
