set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./castopod-media
mkdir -p ./castopod-db
mkdir -p ./castopod-cache

# chown -R 1000:1000 ./data
