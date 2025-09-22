#!/usr/bin/env python3
import time
import subprocess
import os
import json
from datetime import datetime

def log_message(message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] {message}"
    print(log_entry)
    with open('monitor.log', 'a') as log_file:
        log_file.write(log_entry + '\n')

def load_config():
    config = {
        'check_interval': 30,
        'max_retries': 3,
        'backup_before_apply': True
    }
    if os.path.exists('sync_config.json'):
        with open('sync_config.json', 'r') as f:
            user_config = json.load(f)
            config.update(user_config)
    return config

def main():
    config = load_config()
    log_message("🚀 iPhone Sync Monitor Started")
    log_message(f"📊 Configuration: {config}")
    
    retry_count = 0
    while True:
        try:
            # Pull latest changes
            result = subprocess.run(['git', 'pull'], capture_output=True, text=True)
            
            if result.returncode == 0:
                if "Already up to date" not in result.stdout:
                    log_message("🔄 New configuration detected!")
                    
                    # Backup before applying if enabled
                    if config['backup_before_apply']:
                        subprocess.run(['git', 'add', '.'])
                        subprocess.run(['git', 'commit', '-m', f"Pre-apply backup {datetime.now()}"])
                    
                    # Apply configuration
                    if os.path.exists('./apply_config.sh'):
                        apply_result = subprocess.run(['./apply_config.sh'], capture_output=True, text=True)
                        log_message(f"🔧 Apply script output: {apply_result.stdout}")
                        if apply_result.stderr:
                            log_message(f"⚠️ Apply script errors: {apply_result.stderr}")
                    
                    retry_count = 0  # Reset retry count on success
                else:
                    if retry_count == 0:  # Only log once per successful check
                        log_message("✅ System up to date")
            else:
                retry_count += 1
                log_message(f"❌ Git pull failed (attempt {retry_count}): {result.stderr}")
                
                if retry_count >= config['max_retries']:
                    log_message("🆘 Maximum retries reached, waiting for next cycle")
                    retry_count = 0
                    
        except Exception as e:
            log_message(f"💥 Unexpected error: {e}")
            retry_count += 1
            
        time.sleep(config['check_interval'])

if __name__ == "__main__":
    main()
