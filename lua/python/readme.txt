�뽫 <your_username> �滻Ϊ����û��������� ExecStart �е�·���滻Ϊ��� start_scheduler.sh �ű���ʵ��·����
sudo systemctl daemon-reload
sudo systemctl start scheduler
sudo systemctl enable scheduler
���ڣ���� Python ���ȳ���Ӧ����Ϊһ���ػ��������У������˳����Զ�������
�����ͨ�� systemctl status scheduler �鿴����״̬������ʹ�� journalctl -u scheduler �鿴��־��

pip3 install watchdog
yum install mysql-devel
yum install -y gcc
pip3 install mysqlclient
pip3 install dbutils
pip3 install apscheduler