cp docker/production/app/Dockerfile .
sed -i 's/COPY castopod /COPY .\/ /' ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/castopodapp:latest | docker load
