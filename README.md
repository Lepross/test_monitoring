# Установка системы мониторинга

## Установка скрипта

mv test_monitor.sh /usr/local/bin/test_monitor.sh

sudo chmod +x /usr/local/bin/test_monitor.sh

## Установка сервисов

mv test-monitor.service /etc/systemd/system/test-monitor.service

mv test-monitor.timer /etc/systemd/system/test-monitor.timer

mv test-monitor-run.service /etc/systemd/system/test-monitor-run.service

## Активация сервисов
sudo systemctl daemon-reload

sudo systemctl enable test-monitor.service

sudo systemctl enable test-monitor.timer

sudo systemctl start test-monitor.timer

## Создание лог-файла
sudo touch /var/log/monitoring.log

sudo chmod 644 /var/log/monitoring.log
