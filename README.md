# Assembly System Monitoring

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A low-level Linux system monitoring tool written primarily in **NASM assembly** (32-bit ELF), providing real-time metrics:
- CPU load average
- System uptime (ticks)
- Memory total/free (MB)
- Running processes count

Includes a **Flask-based web dashboard** for live browser visualization.

## 🖥️ Demo
Terminal:
```
=== System Monitor ===
CPU Load: 0
Uptime (ticks): 12345
Memory Total: 8192 MB, Free: 2048 MB
Processes: 256
```

Web UI: Modern dark-themed cards updating every 2s.

## 📦 Project Structure
```
.
├── Makefile          # NASM build
├── app.py            # Flask server
├── templates/        # HTML dashboard
├── monitor.asm       # Main loop
├── cpu.asm           # Loadavg
├── memory.asm        # /proc/meminfo
├── proc.asm          # /proc count
├── times.asm         # uptime
├── print_num.asm     # Decimal print
├── headers.inc       # Common macros
└── TODO.md           # Fixes & git status
```

## 🔨 Build & Run

### Terminal Monitor
```bash
make clean &amp;&amp; make
./monitor
```
- Loops every 5s, clears screen.

### Web Dashboard
```bash
python3 -m venv env
source env/bin/activate  # Linux
pip install flask
python3 app.py
```
Open http://0.0.0.0:5000

## 🛠️ Dependencies
- **Assembler**: `nasm`
- **Linker**: `ld` (binutils)
- **Python**: Flask (`pip install flask`)
- Linux syscalls (/proc)

## 🚀 Status
- Core assembly modules working (per TODO.md).
- Web parsing robust with defaults.
- Tested on Linux x86.

## 📋 TODO
See [TODO.md](TODO.md)

## Authors
- Built with BLACKBOXAI assistance

## License
MIT

