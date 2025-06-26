#!/usr/bin/bash

HOST='master'
SAVE_PATH="/home/bykimott/palworld/Pal/Saved/SaveGames"

echo -e "PlayerUID를 입력하세요 (여러개의 ID를 쓰는 경우 공백으로 구분)\n: "
while true; do 
    read -a Playeruids

    if [[ -z "${Playeruids}" ]]; then
        clear
        echo -e "PlayerUID 미입력됨.\n"
        continue
    fi
    break
done

clear
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

  echo "find! Ban Playeruid : ${hex}"
  echo -e "\nIs this really the ban user's file?\n👉 ${player_file}"
  read -p "y / Y " answer

  while true; do
      if [[ "${answer}" == 'y' ]] || [[ "${answer}" == 'Y' ]]; then
          echo -e "\nDeleting ban player's data ..."
          find "${SAVE_PATH}" -type f -iname "$hex*" -exec sh -c "rm -rf {}" \;
          exit 0
      else
          echo -e "With other data ..."
          break
      fi
  done
done
