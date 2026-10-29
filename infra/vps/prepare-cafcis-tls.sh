#!/usr/bin/env bash
set -Eeuo pipefail

install -d -o root -g root -m 0755 \
    /var/lib/letsencrypt/.well-known/acme-challenge
install -d -o root -g root -m 0755 \
    /etc/letsencrypt/renewal-hooks/deploy

install -o root -g root -m 0644 \
    /tmp/cafcis.ch.conf \
    /etc/nginx/sites-available/cafcis.ch.conf
install -o root -g root -m 0600 \
    /tmp/cafcis.ch-tls.conf \
    /etc/nginx/sites-available/cafcis.ch-tls.conf.prepared
install -o root -g root -m 0755 \
    /tmp/letsencrypt-reload-nginx.sh \
    /etc/letsencrypt/renewal-hooks/deploy/reload-nginx.sh

touch /var/lib/letsencrypt/.well-known/acme-challenge/cafcis-acme-check
chown root:root /var/lib/letsencrypt/.well-known/acme-challenge/cafcis-acme-check
chmod 0644 /var/lib/letsencrypt/.well-known/acme-challenge/cafcis-acme-check

nginx -t
systemctl reload nginx

echo "Préparation TLS de CAFCIS terminée."
