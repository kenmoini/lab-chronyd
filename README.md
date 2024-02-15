# Container as a Service - NTP (Chronyd)

## Installation

```bash
cd /opt

git clone https://github.com/kenmoini/lab-chronyd

cd lab-chronyd

# Modify config/chrony.conf as needed

cp lab-chronyd.service /etc/systemd/system/

systemctl daemon-reload

systemctl enable --now lab-chronyd.service
```