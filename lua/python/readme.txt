请将 <your_username> 替换为你的用户名，并将 ExecStart 中的路径替换为你的 start_scheduler.sh 脚本的实际路径。
sudo systemctl daemon-reload
sudo systemctl start scheduler
sudo systemctl enable scheduler
现在，你的 Python 调度程序应该作为一个守护进程运行，并在退出后自动重启。
你可以通过 systemctl status scheduler 查看服务状态，或者使用 journalctl -u scheduler 查看日志。

pip3 install watchdog
yum install mysql-devel
yum install -y gcc
pip3 install mysqlclient
pip3 install dbutils
pip3 install apscheduler