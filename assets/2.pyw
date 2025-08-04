import configparser
import os
import requests

def send_webhook_message():
    # Get parent folder path
    parent_folder = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    config_path = os.path.join(parent_folder, 'config.ini')

    # Read config.ini
    config = configparser.ConfigParser()
    config.read(config_path)

    # Get webhook URL and Discord ID
    webhook_url = config.get('Webhook', 'WebhookLink', fallback=None)
    discord_id = config.get('Webhook', 'DID', fallback=None)

    if not webhook_url:
        print("Webhook URL not found in config")
        return
    if not discord_id:
        print("Discord ID not found in config")
        return

    # Create message mentioning the user
    message = f"<@{discord_id}> This is a Test Message."

    # Prepare payload
    payload = {
        "content": message
    }

    # Send POST request to webhook
    response = requests.post(webhook_url, json=payload)

    if response.status_code == 204:
        print("Sent")
    else:
        print(f"Failed: {response.status_code}, Response: {response.text}")

if __name__ == "__main__":
    send_webhook_message()