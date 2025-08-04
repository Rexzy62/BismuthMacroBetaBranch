import os
import glob
import time
import json
import requests
import configparser

def read_webhook_url_from_ini(ini_path):
    config = configparser.ConfigParser()
    config.read(ini_path)
    try:
        return config['Webhook']['WebhookLink']
    except KeyError:
        print("")
        return None

def get_newest_log_file(log_dir):
    log_files = glob.glob(os.path.join(log_dir, "*.log"))
    if not log_files:
        print("No log files")
        return None
    newest_file = max(log_files, key=os.path.getmtime)
    return newest_file

def send_webhook_message(webhook_url, biome):
    message = f"Detected Biome: **{biome}**"
    payload = {"content": message}
    try:
        resp = requests.post(webhook_url, json=payload)
        if resp.status_code == 204:
            print(f"Sent!: {message}")
        else:
            print(f"to send webhook: {resp.status_code} {resp.text}")
    except Exception as e:
        print(f"Exception sending webhook: {e}")

def tail_log_file(path, webhook_url, keyword="[BloxstrapRPC]"):
    print(f"Current log: {path}")
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        f.seek(0, 2)
        while True:
            line = f.readline()
            if not line:
                time.sleep(0.1)
                continue
            if keyword in line:
                try:
                    json_start = line.index(keyword) + len(keyword)
                    json_str = line[json_start:].strip()
                    data = json.loads(json_str)
                    biome = data.get('data', {}).get('largeImage', {}).get('hoverText')
                    print(f"Found presence data: {data}")
                    if biome:
                        send_webhook_message(webhook_url, biome)
                    else:
                        print("Could not find biome info in presence data")
                except Exception as e:
                    print(f"Failed to parse JSON or send webhook: {e}")
                    print("Raw line:", line.strip())

if __name__ == "__main__":
    # Path to the Roblox logs folder
    roblox_log_dir = os.path.expandvars(r"%LOCALAPPDATA%\Roblox\logs")
    # Path to your config.ini, adjust if needed (parent dir of this script assumed)
    ini_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "config.ini")
    
    webhook_url = read_webhook_url_from_ini(ini_path)
    if not webhook_url:
        exit(1)
    
    newest_log = get_newest_log_file(roblox_log_dir)
    if newest_log:
        tail_log_file(newest_log, webhook_url)
