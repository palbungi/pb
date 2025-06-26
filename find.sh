#!/usr/bin/bash

HOST='bykimott'
SAVE_PATH="/home/${HOST}/palworld/Pal/Saved/SaveGames/0/0E5CEC4FB53C484D981BD8CA675709A8/"

echo -e "PlayerUID를 입력하세요 (여러개의 ID를 쓰는 경우 공백으로 구분)\n: "
while true; do 
    read -a Playeruids

    if [[ -z "${Playeruids}" ]]; then
        echo -e "PlayerUID 미입력됨.\n"
        continue
    fi
    break
done

echo "플레이어 데이터 찾는 중 ..."
for playeruid in "${Playeruids[@]}"; do
  hex=$(printf "%X\n" "$playeruid" 2>/dev/null)
  if [[ "${hex}" == 0 ]]; then
    echo -e "${playeruid}: invalid octal number!"
    continue
  fi

  player_file="$(find "${SAVE_PATH}" -type f -iname "$hex*")"
  if [[ -z  "${player_file}" ]]; then
      echo -e "해당되는 플레이어를 찾지 못했습니다."
      continue
  fi

echo "find! Playeruid : ${hex}"
echo "save file👉 ${player_file}"
done
