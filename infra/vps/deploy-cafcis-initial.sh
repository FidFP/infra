#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 || ! $1 =~ ^[0-9]{8}-[0-9]{6}$ ]]; then
    echo "Usage: $0 AAAAMMJJ-HHMMSS" >&2
    exit 2
fi

release_id=$1
staging_dir="/tmp/cafcis-${release_id}"
site_root="/srv/www/cafcis.ch"
release_dir="${site_root}/releases/${release_id}"

required_files=(
    index.html
    cafcis-demande-af.pdf
    favicon.png
    favicon_bas.png
    icon-pdf.png
    logo_petit.png
    Statuts_CAFCIS.png
)

for file in "${required_files[@]}"; do
    if [[ ! -f "${staging_dir}/${file}" ]]; then
        echo "Fichier requis absent : ${staging_dir}/${file}" >&2
        exit 1
    fi
done

if find "${staging_dir}" -type l -print -quit | grep -q .; then
    echo "Le transfert contient un lien symbolique inattendu." >&2
    exit 1
fi

if [[ -e "${release_dir}" ]]; then
    echo "La version existe déjà : ${release_dir}" >&2
    exit 1
fi

install -d -o root -g root -m 0755 "${site_root}/releases" "${release_dir}"
cp -a "${staging_dir}/." "${release_dir}/"
chown -R root:root "${release_dir}"
find "${release_dir}" -type d -exec chmod 0755 {} +
find "${release_dir}" -type f -exec chmod 0644 {} +

ln -sfn "${release_dir}" "${site_root}/current"

install -o root -g root -m 0644 \
    /tmp/00-default-deny.conf \
    /etc/nginx/sites-available/00-default-deny.conf
install -o root -g root -m 0644 \
    /tmp/cafcis.ch.conf \
    /etc/nginx/sites-available/cafcis.ch.conf

default_was_enabled=false
if [[ -e /etc/nginx/sites-enabled/default || -L /etc/nginx/sites-enabled/default ]]; then
    if [[ -e /etc/nginx/default-site.disabled || -L /etc/nginx/default-site.disabled ]]; then
        echo "Sauvegarde du site Nginx par défaut déjà présente." >&2
        exit 1
    fi
    mv /etc/nginx/sites-enabled/default /etc/nginx/default-site.disabled
    default_was_enabled=true
fi

ln -sfn /etc/nginx/sites-available/00-default-deny.conf \
    /etc/nginx/sites-enabled/00-default-deny.conf
ln -sfn /etc/nginx/sites-available/cafcis.ch.conf \
    /etc/nginx/sites-enabled/cafcis.ch.conf

if ! nginx -t; then
    unlink /etc/nginx/sites-enabled/00-default-deny.conf || true
    unlink /etc/nginx/sites-enabled/cafcis.ch.conf || true
    if [[ $default_was_enabled == true ]]; then
        mv /etc/nginx/default-site.disabled /etc/nginx/sites-enabled/default
    fi
    nginx -t
    echo "Configuration refusée ; activation annulée." >&2
    exit 1
fi

systemctl reload nginx

curl --fail --silent --show-error \
    --header 'Host: cafcis.ch' \
    http://127.0.0.1/ >/dev/null

echo "CAFCIS ${release_id} déployé et testé localement."
