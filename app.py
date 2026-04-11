from flask import Flask, render_template, jsonify
import subprocess
import re

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/data')
def get_data():
    try:
        result = subprocess.run(['python3', 'monitor.py'], capture_output=True, text=True, timeout=10)
        stdout = result.stdout
        
        data = {
            "uptime": "Unknown",
            "cpu_detail": "0%",
            "mem_total": 0,
            "mem_used": 0,
            "mem_free": 0,
            "mem_cached": 0,
            "net_down": "0 kB/s",
            "net_up": "0 kB/s",
            "processes": []
        }
        
        # Parsing lines
        lines = stdout.split('\n')
        is_proc_section = False
        
        for line in lines:
            line = line.strip()
            if not line: continue
            
            if 'Uptime:' in line: data["uptime"] = line.split('Uptime:')[1].strip()
            if 'CPU usage:' in line: data["cpu_detail"] = line.split('CPU usage:')[1].strip()
            if 'MEM Total:' in line: data["mem_total"] = line.split('MEM Total:')[1].split()[0]
            if 'MEM Used:' in line: data["mem_used"] = line.split('MEM Used:')[1].split()[0]
            if 'MEM Free:' in line: data["mem_free"] = line.split('MEM Free:')[1].split()[0]
            if 'MEM Cached:' in line: data["mem_cached"] = line.split('MEM Cached:')[1].split()[0]
            if 'NET Download:' in line: data["net_down"] = line.split('NET Download:')[1].strip()
            if 'NET Upload:' in line: data["net_up"] = line.split('NET Upload:')[1].strip()
            
            if 'TOP_PROCESSES_START' in line:
                is_proc_section = True
                continue
            if 'TOP_PROCESSES_END' in line:
                is_proc_section = False
                continue
                
            if is_proc_section:
                parts = line.split('|')
                if len(parts) == 3:
                    data["processes"].append({
                        "pid": parts[0],
                        "name": parts[1],
                        "mem": parts[2]
                    })
                    
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)})

@app.route('/refresh_system', methods=['POST'])
def refresh_system():
    try:
        # 1. Sync data ke disk
        subprocess.run(['sync'], check=True)
        # 2. Lepaskan PageCache, dentries, dan inodes (Membersihkan RAM Cache)
        # Perintah ini aman dan tidak akan mematikan aplikasi yang sedang berjalan
        subprocess.run(['sh', '-c', 'echo 3 > /proc/sys/vm/drop_caches'], check=True)
        return jsonify({"status": "success", "message": "RAM Cache Cleared"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
