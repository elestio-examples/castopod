cp docker/production/app/Dockerfile .
sed -i "s~COPY castopod /opt/castopod~COPY ./ /opt/castopod~g" ./Dockerfile
docker build . --tag elestio4test/traduora:latest;
# TAG_TO_CHANGE