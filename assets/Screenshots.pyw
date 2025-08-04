import os
import configparser
import requests

# Get script directory and parent directory
script_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.abspath(os.path.join(script_dir, os.pardir))

# Load config.ini from parent directory
config_path = os.path.join(parent_dir, "config.ini")
config = configparser.ConfigParser()
config.read(config_path)

webhook_url = config.get("Webhook", "WebhookLink", fallback=None)

if not webhook_url:
    print("❌ Webhook URL not found in config.ini.")
    exit(1)

# Screenshot names and paths
screenshot_names = [
    "QuestProgress.png",
    "GauntletStorage.png",
    "PotionStorage.png"
]
screenshot_dir = os.path.join(script_dir, "macros", "screens")
screenshot_paths = [
    (name, os.path.join(screenshot_dir, name)) for name in screenshot_names
]

# Collect only existing files
files_to_send = [
    ("files[{}]".format(i), (name, open(path, "rb"), "image/png"))
    for i, (name, path) in enumerate(screenshot_paths) if os.path.exists(path)
]

# Build embed
embeds = [{
    "title": "Screenshots",
    "description": "\n".join(f"- {name}" for name, path in screenshot_paths if os.path.exists(path)),
    "image": {"url": f"attachment://{files_to_send[0][1][0]}"} if files_to_send else None
}]

# Send the embed + files
payload = {
    "embeds": embeds
}

with requests.Session() as session:
    response = session.post(
        webhook_url,
        data={"payload_json": str(payload).replace("'", '"')},
        files=files_to_send
    )

    if response.status_code == 204:
        print("✅ Screenshots sent successfully.")
    else:
        print(f"❌ Failed to send. Status: {response.status_code}, Response: {response.text}")
