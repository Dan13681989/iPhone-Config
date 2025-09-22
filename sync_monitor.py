#!/usr/bin/env python3
import time
import subprocess
import os

print("Sync monitor started...")
while True:
    try:
        result = subprocess.run(['git', 'pull'], capture_output=True, text=True)
        if result.returncode == 0:
            if "Already up to date" not in result.stdout:
                print("New configuration detected!")
                if os.path.exists('./apply_config.sh'):
                    subprocess.run(['./apply_config.sh'])
            else:
                print("Up to date - waiting...")
        else:
            print(f"Git pull failed: {result.stderr}")
    except Exception as e:
        print(f"Error: {e}")
    time.sleep(30)
