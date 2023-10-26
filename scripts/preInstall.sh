set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data
mkdir -p ./castopod-media


chown -R 1000:1000 ./data
chown -R 1000:1000 ./castopod-media

cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

# Read the file line by line
while IFS= read -r line; do
  # Extract the values after the flags (-e)
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  # Loop through each value and store in respective variables
  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"

cat << EOT >> ./.env

CP_EMAIL_SMTP_HOST=tuesday.mxrouting.net
CP_EMAIL_FROM=${SMTP_LOGIN}
CP_EMAIL_SMTP_USERNAME=${SMTP_LOGIN}
CP_EMAIL_SMTP_PASSWORD=${SMTP_PASSWORD}
CP_EMAIL_SMTP_PORT=465
CP_EMAIL_SMTP_CRYPTO=ssl
EOT

rm post.txt