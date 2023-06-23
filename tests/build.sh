cp docker/production/app/Dockerfile .
sed -i "s~COPY castopod /var/www/castopod~COPY ./ /var/www/castopod~g" ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i RUN curl -fsSL https:\/\/deb.nodesource.com\/setup_18.x -o nodejs_setup.sh' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i  RUN chmod +x nodejs_setup.sh' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i  RUN ./nodejs_setup.sh' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i  RUN chmod +x nodejs_setup.sh' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i  RUN apt-get update' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i  RUN apt-get install --yes --no-install-recommends nodejs' ./Dockerfile


sed -i '/WORKDIR \/var\/www\/castopod/i RUN curl -sS https:\/\/getcomposer.org\/installer | php -- --install-dir=\/usr\/local\/bin --filename=composer' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/i RUN apt-get install -y git' ./Dockerfile

sed -i '/WORKDIR \/var\/www\/castopod/i\
RUN apt-get update \\\
    && apt-get install --yes --no-install-recommends \\\
        gnupg \\\
        openssh-client \\\
        libicu-dev \\\
        libpng-dev \\\
        libjpeg62-turbo-dev \\\
        libfreetype6-dev \\\
        zlib1g-dev \\\
        libzip-dev \\\
        unzip \\\
        ffmpeg \\\
        libwebp-dev \\\
        cron \\\
    && docker-php-ext-install intl \\\
    && docker-php-ext-install zip \\\
    && docker-php-ext-configure gd --with-jpeg --with-freetype \\\
    && docker-php-ext-install -j$(nproc) gd \\\
    && docker-php-ext-install exif \\\
    && pecl install -o -f redis \\\
    && rm -rf /tmp/pear \\\
    && docker-php-ext-enable redis \\\
    && docker-php-ext-install mysqli \\\
    && docker-php-ext-enable mysqli \\\
    && echo "file_uploads = On \\n" \\\
       "memory_limit = 512M\\n" \\\
       "upload_max_filesize = 500M\\n" \\\
       "post_max_size = 512M\\n" \\\
       "max_execution_time = 300\\n" \\\
       > /usr/local/etc/php/conf.d/uploads.ini' ./Dockerfile


sed -i '/WORKDIR \/var\/www\/castopod/a RUN composer install --prefer-dist --no-ansi --no-interaction --no-progress --ignore-platform-reqs' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/a RUN npm run build:static' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/a RUN npm run build' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/a RUN npm install -g pnpm typescript' ./Dockerfile
sed -i '/WORKDIR \/var\/www\/castopod/a RUN npm install' ./Dockerfile




docker build . --tag elestio4test/castopod-app:latest;
rm Dockerfile

cp docker/production/web-server/Dockerfile .
sed -i "s~COPY castopod/public /var/www/html~COPY ./public /var/www/html~g" ./Dockerfile
sed -i "/WORKDIR \/var\/www\/html\/a RUN chmod +x 755 /var/www/html/." ./Dockerfile
docker build . --tag elestio4test/web-server:latest;
rm Dockerfile
# TAG_TO_CHANGE