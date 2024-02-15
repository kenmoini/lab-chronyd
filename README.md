# Container as a Service - NTP (Chronyd)

## Installation

```bash
dnf install podman -y

systemctl enable --now podman.socket

cd /opt

git clone https://github.com/kenmoini/lab-chronyd

cd lab-chronyd

# Modify config/chrony.conf as needed

cp lab-chronyd.service /etc/systemd/system/

systemctl daemon-reload

systemctl enable --now lab-chronyd.service
```

## Checking

```bash
podman exec lab-chronyd chronyc sources -v

podman exec lab-chronyd chronyc tracking -v

podman exec lab-chronyd chronyc ntpdata

podman exec lab-chronyd chronyc sourcestats

systemctl restart lab-chronyd.service
```