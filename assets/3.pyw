import json
import configparser
import os
import requests

def send_webhook_embed():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    image_path = os.path.join(script_dir, 'testImg.gif')

    parent_folder = os.path.abspath(os.path.join(script_dir, '..'))
    config_path = os.path.join(parent_folder, 'config.ini')

    config = configparser.ConfigParser()
    config.read(config_path)

    webhook_url = config.get('Webhook', 'WebhookLink', fallback=None)
    discord_id = config.get('Webhook', 'DID', fallback=None)

    if not webhook_url:
        print("Webhook URL not found in config")
        return
    if not discord_id:
        print("Discord ID not found in config")
        return
    if not os.path.isfile(image_path):
        print(f"Image file NF: {image_path}")
        return

    content = f"<@{discord_id}>"
    embed = {
        "title": "Test Embed!",
        "description": "Cat - Sent from Bismuth Macro",
        "image": {
            "url": "attachment://testImg.png"
        }
    }

    payload = {
        "content": content,
        "embeds": [embed]
    }

    with open(image_path, 'rb') as f:
        files = {
            'file': ('testImg.png', f)
        }
        data = {
            'payload_json': json.dumps(payload)
        }
        response = requests.post(webhook_url, data=data, files=files)

    if response.status_code == 204:
        print("sent")
    else:
        print(f"Failed: {response.status_code}, Response: {response.text}")

if __name__ == "__main__":
    send_webhook_embed()
