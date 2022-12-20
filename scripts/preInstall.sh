set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./castopod-media
mkdir -p ./castopod-db
mkdir -p ./castopod-cache

chown -R 544:544 ./data
chown -R 544:544 ./castopod-media
chown -R 544:544 ./castopod-db
chown -R 544:544 ./castopod-cache
