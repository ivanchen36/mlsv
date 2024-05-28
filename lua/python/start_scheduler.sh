[Unit]
Description=Scheduler Daemon
After=network.target

[Service]
User=<your_username>
ExecStart=/path/to/start_scheduler.sh
Restart=always
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target