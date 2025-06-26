#!/usr/bin/bash

HOST='bykimott'
YAML_FILE="/home/$HOST/docker-compose.yml"
CONTAINER_NAME="palworld"
THRESHOLD=95

# 변수에 각각 삽입
read total used <<< $(free -m | awk '/Mem:/ {print $2 " " $3}')

# 현재 메모리 사용량 출력
echo "Current Memory usage: $(awk '/MemTotal/{total=$2}/MemAvailable/{available=$2} END {printf "%.0f", (total-available) / total * 100}' /proc/meminfo)%"

# 메모리 사용량 계산(사용량이 10%보다 낮다면 스크립스 실행)
usedPct=$(( used * 100 / total ))
if [[  "$usedPct" -gt $THRESHOLD ]]; then
    echo "Memory usage is above $THRESHOLD%."
    docker exec -i ${CONTAINER_NAME} rcon-cli "Broadcast Server_will_shut_down_in_5_seconds_for_maintance_Please_log_out"

    # 5초 대기
    sleep 5

    # 세이브
    docker exec -i $CONTAINER_NAME rcon-cli save

    # 서버 종료
    docker exec -i $CONTAINER_NAME rcon-cli "Broadcast Server_is_shutting_down_for_maintance"

    # 5초 대기
    sleep 5

    # 서버 재시작
    docker-compose -f "${YAML_FILE}" pull
    docker-compose -f "${YAML_FILE}" down
    docker-compose -f "${YAML_FILE}" up -d
else
    echo "Memory usage is below $THRESHOLD%."
fi
