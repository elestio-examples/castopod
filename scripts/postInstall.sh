set env vars
set -o allexport; source .env; set +o allexport;

sleep 20s;

target=$(docker-compose port web-server 80)


curl http://${target}/cp-install/create-superadmin \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36' \
  --data-raw 'csrf_test_name=53912d3c64b0ef0888e3a8d4bcf93d676bfc58a8eb2ad1e7424e73ffe215405b&username=root&email='$ADMIN_EMAIL'&password='$ADMIN_PASSWORD'' \
  --compressed