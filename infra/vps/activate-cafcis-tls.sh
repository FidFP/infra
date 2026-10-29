#!/usr/bin/env bash
set -Eeuo pipefail

live_config=/etc/nginx/sites-available/cafcis.ch.conf
tls_config=/etc/nginx/sites-available/cafcis.ch-tls.conf.prepared
backup_config=/etc/nginx/sites-available/cafcis.ch.conf.before-tls

for file in \
    /etc/letsencrypt/live/cafcis.ch/fullchain.pem \
    /etc/letsencrypt/live/cafcis.ch/privkey.pem \
    "${live_config}" \
    "${tls_config}"; do
    if [[ ! -f "${file}" ]]; then
        echo "Fichier requis absent : ${file}" >&2
        exit 1
    fi
done

cp -a "${live_config}" "${backup_config}"
install -o root -g root -m 0644 "${tls_config}" "${live_config}"

rollback() {
    install -o root -g root -m 0644 "${backup_config}" "${live_config}"
    nginx -t
    systemctl reload nginx
}

if ! nginx -t; then
    rollback
    echo "Configuration TLS refusée ; retour à HTTP effectué." >&2
    exit 1
fi

systemctl reload nginx

https_ok=false
for _attempt in 1 2 3 4 5; do
    if curl --fail --silent --show-error \
        --resolve cafcis.ch:443:127.0.0.1 \
        https://cafcis.ch/ >/dev/null; then
        https_ok=true
        break
    fi
    sleep 1
done

if [[ ${https_ok} != true ]]; then
    rollback
    echo "Test HTTPS local échoué ; retour à HTTP effectué." >&2
    exit 1
fi

http_code=000
for _attempt in 1 2 3 4 5; do
    http_code=$(curl --silent --output /dev/null --write-out '%{http_code}' \
        --header 'Host: cafcis.ch' http://127.0.0.1/)
    if [[ ${http_code} == 301 ]]; then
        break
    fi
    sleep 1
done

if [[ ${http_code} != 301 ]]; then
    rollback
    echo "Redirection HTTP échouée (code ${http_code}) ; retour à HTTP effectué." >&2
    exit 1
fi

rm -f /var/lib/letsencrypt/.well-known/acme-challenge/cafcis-acme-check

echo "HTTPS CAFCIS activé et testé localement."
