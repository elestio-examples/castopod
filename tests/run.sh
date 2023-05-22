#!/usr/bin/env bash

mkdir -p ./data
mkdir -p ./castopod-media


chown -R 1000:1000 ./data
chown -R 1000:1000 ./castopod-media

docker-compose up -d;
sleep 30s;