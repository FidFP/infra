#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y full-upgrade

install -o root -g root -m 0644 \
  /tmp/99-fiduciaire-hardening.conf \
  /etc/ssh/sshd_config.d/99-fiduciaire-hardening.conf

install -d -o root -g root -m 0755 /run/sshd
sshd -t

ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp comment 'SSH administration'
ufw allow 80/tcp comment 'HTTP ACME and redirect'
ufw allow 443/tcp comment 'HTTPS sites and applications'
ufw --force enable

systemctl restart ssh
systemctl reset-failed cloud-final.service fwupd.service || true

