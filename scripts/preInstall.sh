set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./castopod-media
mkdir -p ./castopod-db
mkdir -p ./castopod-cache

chown -R 444:444 ./data
chown -R 444:444 ./castopod-media
chown -R 444:444 ./castopod-db
chown -R 444:444 ./castopod-cache
