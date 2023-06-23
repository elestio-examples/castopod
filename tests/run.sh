#!/usr/bin/env bash

mkdir -p ./data
mkdir -p ./castopod-media


chown -R 1000:1000 ./data
chown -R 1000:1000 ./castopod-media

docker-compose up -d;

if grep -q '^BASE_URL=http://' .env && ! grep -q '^BASE_URL=https://' .env; then
    docker exec castopod_app_1 sed -i 's/\$forceGlobalSecureRequests.*=.*true.*;/\$forceGlobalSecureRequests=false\;/' /var/www/castopod/app/Config/App.php
elif ! grep -q '^BASE_URL=http://' .env && grep -q '^BASE_URL=https://' .env; then
    docker exec castopod_app_1 sed -i 's/\$forceGlobalSecureRequests.*=.*false.*;/\$forceGlobalSecureRequests=true\;/' /var/www/castopod/app/Config/App.php
else
    echo "Line conditions not satisfied"
fi

docker exec castopod_app_1 chmod -R 755 /var/www/castopod/.

rm -rf /tmp/castopod
mkdir  -p  /tmp/castopod/public
docker cp  castopod_app_1:var/www/castopod/public/. /tmp/castopod/public
docker cp  /tmp/castopod/public/. castopod_web-server_1:var/www/html/

docker exec castopod_web-server_1 chmod -R 755 /var/www/html/.
sleep 30s;