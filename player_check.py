import subprocess
import time

TARGET_PORT = 8211
CONTAINER_NAME = "palworld"

def run_command(command):
    result = subprocess.run(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, text=True
    )
    return result.stdout.strip()

def check_players():
    players_output = run_command(
        f"docker exec {CONTAINER_NAME} rcon-cli ShowPlayers"
    )
    print(f"player: {players_output}")
    return "," in players_output.replace("name,playeruid,steamid", "")

def main():
    if not check_players():
        print("No players found. Restarting server.")
        run_command(f"docker restart {CONTAINER_NAME}")

        for sec in range(5, 0, -1):
            print(f"Waiting for restart to complete... {sec} seconds left")
            time.sleep(1)
    else:
        print("Players found. Server will continue running.")

    time.sleep(1)

if __name__ == "__main__":
        main()
