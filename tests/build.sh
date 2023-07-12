cp docker/production/app/Dockerfile ./
sed -i "s~COPY castopod /opt/castopod~COPY ./ /opt/castopod~g" ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/castopod-app:latest | docker load
