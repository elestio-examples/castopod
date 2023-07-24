cp docker/production/castopod/Dockerfile .
mkdir ./castopod
chmod +x ./castopod
cp -rf ./app ./castopod
cp -rf ./modules ./castopod
cp -rf ./public ./castopod
cp -rf ./themes ./castopod
cp -rf ./vendor ./castopod
cp -rf ./writable ./castopod
cp -rf ./env.example ./castopod
cp -rf LICENSE.md README.md ./castopod
cp -rf ./spark ./castopod
# sed -i 's/COPY castopod /COPY .\/ /' ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/castopod:latest | docker load
