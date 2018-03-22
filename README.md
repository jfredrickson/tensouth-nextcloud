# Nextcloud server stack

A Docker deployment of Nextcloud. This is modeled on [Nextcloud's docker-compose FPM example](https://github.com/nextcloud/docker#base-version---fpm).

## Setup

First, configure the database username and password via the `.env` file. Use the `sample.env` file as a basis for creating the `.env` file.

After the `.env` file is in place, build and deploy:

```
cd nextcloud
docker-compose up -d
```

Upon initial deployment, Nextcloud will be available at [http://localhost:8020/]. You will have to create a new admin account. The database connection information does not matter because it will be overridden by environment variables.
