# 한국시간 설정
sudo timedatectl set-timezone Asia/Seoul

# 도커&도커컴포즈 설치
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo apt update && sudo apt -y upgrade && sudo apt install -y nano && sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && yes | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/v2.37.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chmod 666 /var/run/docker.sock

# 팰월드 도커 및 서버 재시작 스크립트 다운로드
wget https://raw.githubusercontent.com/palbungi/pb/refs/heads/main/docker-compose.yml
wget https://raw.githubusercontent.com/palbungi/pb/refs/heads/main/config.env
wget https://raw.githubusercontent.com/palbungi/pb/refs/heads/main/regular_maintenance.sh


# 서버 재시작 스크립트에 실행 권한 추가
chmod +x /home/$(whoami)/regular_maintenance.sh

# 서버 재시작 예약(10분전 알림 후 재시작 하므로 3:50, 7:50, 11:50, 15:50, 19:50, 23:50에 각각 등록)
(sudo crontab -l 2>/dev/null; echo "* */1 * * * /usr/bin/python3 /home/$(whoami)/player_check.py") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 03 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 07 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 11 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 15 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 19 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -
(sudo crontab -l 2>/dev/null; echo "50 23 * * * /home/$(whoami)/regular_maintenance.sh") | sudo crontab -

# 서버 디렉토리 생성 및 설정파일 다운로드(Engine.ini 최적화, GameUserSettings.ini 서버저장 디렉토리 지정)
mkdir -p /home/$(whoami)/palworld/Pal/Saved/Config/LinuxServer
wget -P /home/$(whoami)/palworld/Pal/Saved/Config/LinuxServer https://raw.githubusercontent.com/palbungi/pb/refs/heads/main/Engine.ini
wget -P /home/$(whoami)/palworld/Pal/Saved/Config/LinuxServer https://raw.githubusercontent.com/palbungi/pb/refs/heads/main/GameUserSettings.ini

# 서버 모드 디렉토리 생성 및 다운로드
mkdir -p /home/$(whoami)/palworld/Pal/Content/Paks/LogicMods
wget -P /home/$(whoami)/palworld/Pal/Content/Paks/LogicMods https://github.com/palbungi/pb/raw/refs/heads/main/LogicMods/060BNL_P.pak
wget -P /home/$(whoami)/palworld/Pal/Content/Paks/LogicMods https://github.com/palbungi/pb/raw/refs/heads/main/LogicMods/060CampPalSickBuff1000_P.pak
wget -P /home/$(whoami)/palworld/Pal/Content/Paks/LogicMods https://github.com/palbungi/pb/raw/refs/heads/main/LogicMods/060nofalldamage_P.pak
wget -P /home/$(whoami)/palworld/Pal/Content/Paks/LogicMods https://github.com/palbungi/pb/raw/refs/heads/main/LogicMods/060pbshop_P.pak


# 차후 서버이동을 위해 서버저장 폴더 미리 생성(nano 화면에서 새 콘솔창으로 서버데이터 업로드)
mkdir -p /home/$(whoami)/palworld/Pal/Saved/SaveGames/0/0E5CEC4FB53C484D981BD8CA675709A8

# 서버설정 수정
nano config.env

# Portainer 설치 및 실행(웹에서 서버관리)
mkdir /home/$(whoami)/portainer
wget -P /home/$(whoami)/portainer https://github.com/palbungi/pb/raw/refs/heads/main/portainer/docker-compose.yml
docker-compose -f /home/$(whoami)/portainer/docker-compose.yml up -d

# 설치파일 삭제
rm pb
