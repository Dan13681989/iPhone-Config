#!/usr/bin/env python3
import psutil, time, json
from datetime import datetime

def system_stats():
    return {
        'timestamp': datetime.now().isoformat(),
        'cpu_percent': psutil.cpu_percent(),
        'memory_percent': psutil.virtual_memory().percent,
        'disk_usage': psutil.disk_usage('/').percent,
        'docker_containers': len([c for c in psutil.process_iter() if 'docker' in c.name()])
    }

while True:
    stats = system_stats()
    with open('/Users/diba/iphone-sync/monitor_log.json', 'a') as f:
        f.write(json.dumps(stats) + '\n')
    time.sleep(60)
