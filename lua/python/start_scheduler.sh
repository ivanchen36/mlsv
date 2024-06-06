[Unit]
Description=Scheduler Daemon
After=network.target

[Service]
User=ivan
WorkingDirectory=/home/ivan/mlsv/lua/python
ExecStart=/usr/bin/python3 timer.py
Restart=always
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target