cp docker/production/castopod/Dockerfile .
sed -i 's/COPY castopod /var/www/castopod /COPY .\\/ ' ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/castopod-app:latest | docker load
