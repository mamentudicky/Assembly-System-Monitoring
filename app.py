from flask import Flask, render_template, jsonify
import subprocess
import re
import time

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/data')
def get_data():
    # Run monitor with timeout to capture one cycle
    try:
        result = subprocess.run(['./monitor'], capture_output=True, text=True, timeout=6)
        data = {
            "uptime": 0,
            "cpu_load": 0,
            "memory_total": 0,
            "memory_free": 0,
            "processes": 0
        }
        lines = [line.strip() for line in result.stdout.split('\n') if line.strip()]
        for line in lines:
            if 'Uptime (ticks):' in line:
                match = re.search(r'(\d+)', line)
                if match:
                    data["uptime"] = int(match.group(1))
            if 'Memory Total:' in line:
                parts = re.findall(r'(\d+)', line)
                if len(parts) >= 3:
                    data["memory_total"] = int(parts[0])
                    data["memory_free"] = int(parts[2])
            if 'Processes:' in line:
                match = re.search(r'(\d+)', line)
                if match:
                    data["processes"] = int(match.group(1))
            if 'CPU Load:' in line:
                match = re.search(r'(\d+)', line)
                if match:
                    data["cpu_load"] = int(match.group(1))
        return jsonify(data)
    except subprocess.TimeoutExpired:
        return jsonify({"error": "Monitor timeout"})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

