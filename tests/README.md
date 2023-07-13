<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Castopod, verified and packaged by Elestio

A better community platform for the modern web.

[Castopod](https://castopod.org/) is a Hosting Platform for Podcasters Engage with Content.

<img src="https://github.com/elestio-examples/castopod/raw/main/castopod.png" alt="outline" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/castopod">fully managed Castopod</a> on <a target="_blank" href="https://elest.io/">elest.io</a> Application for Podcasters Engage with their Content with Others.

[![deploy](https://github.com/elestio-examples/castopod/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/castopod)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/castopod.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.


Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:8989`

## Docker-compose

Here are some example snippets to help you get started creating a container.

        version: "3.3"
        services:
        app:
            image: elestio4test/castopod:latest
            user: 0:0
            volumes:
            - castopod-media:/opt/castopod/public/media
            - ./data:/castopod
            environment:
            MYSQL_DATABASE: castopod
            MYSQL_USER: castopod
            MYSQL_PASSWORD: changeme
            CP_BASEURL: "https://${BASE_URL}"
            CP_ANALYTICS_SALT: changeme
            CP_CACHE_HANDLER: redis
            CP_REDIS_HOST: redis
            CP_EMAIL_SMTP_HOST: ${CP_EMAIL_SMTP_HOST}
            CP_EMAIL_FROM: ${CP_EMAIL_FROM}
            CP_EMAIL_SMTP_USERNAME: ${CP_EMAIL_SMTP_USERNAME}
            CP_EMAIL_SMTP_PASSWORD: ${CP_EMAIL_SMTP_PASSWORD}
            CP_EMAIL_SMTP_PORT: ${CP_EMAIL_SMTP_PORT}
            CP_EMAIL_SMTP_CRYPTO: ${CP_EMAIL_SMTP_CRYPTO}
            restart: always

        web-server:
            image: castopod/web-server:latest
            volumes:
            - castopod-media:/var/www/html/media
            ports:
            - 172.17.0.1:8989:80
            restart: always

        mariadb:
            image: mariadb:10.5
            volumes:
            - ./castopod-db:/var/lib/mysql
            environment:
            MYSQL_ROOT_PASSWORD: changeme
            MYSQL_DATABASE: castopod
            MYSQL_USER: castopod
            MYSQL_PASSWORD: changeme
            restart: always

        redis:
            image: redis:7.0-alpine
            volumes:
            - ./castopod-cache:/data

        volumes:
        castopod-media:
            driver: local
            driver_opts:
            type: none
            device: ${PWD}/data
            o: bind

### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| BASE_URL             |  [CICD_DOMAIN]  |
| CP_EMAIL_SMTP_HOST   |     URL         |
| CP_EMAIL_FROM        |     Mail ID     |
|CP_EMAIL_SMTP_USERNAME|     UserName    |
|CP_EMAIL_SMTP_PASSWORD|     Password    |
|CP_EMAIL_SMTP_PORT    |     Port        |
|CP_EMAIL_SMTP_CRYPTO  |     Mail ID     |





# Maintenance

## Logging

The Elestio CastoPod Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://docs.castopod.org/">Castopod documentation</a>

- <a target="_blank" href="https://github.com/ad-aures/castopod">Castopod Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/Castopod">Elestio/Castopod Github repository</a>
