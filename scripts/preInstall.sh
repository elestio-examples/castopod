set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./castopod-media
mkdir -p ./castopod-db
mkdir -p ./castopod-cache

chown -R www-data:www-data ./data
chown -R www-data:www-data ./castopod-media
chown -R www-data:www-data ./castopod-db
chown -R www-data:www-data ./castopod-cache
