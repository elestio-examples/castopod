cp docker/production/castopod/Dockerfile ./
sed -i "s~castopod /var/www/castopod ~COPY ./ /var/www/castopod~g" ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/castopod-app:latest | docker load
