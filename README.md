# Nextcloud server stack

A Docker deployment of Nextcloud. This is modeled on [Nextcloud's docker-compose FPM example](https://github.com/nextcloud/docker#base-version---fpm).

## Setup

First, configure the database username and password via the `.env` file. Use the `example.env` file as a basis for creating the `.env` file.

After the `.env` file is in place, build and deploy:

```
cd nextcloud
docker-compose up -d
```

Upon initial deployment, you will have to create a new admin account.

## Upgrading

### Nextcloud updates

```
docker-compose pull
docker-compose build
docker-compose up -d
```

### PostgreSQL upgrades

Dump the data:

```
docker-compose run --rm db pg_dumpall -h db -U postgres > dump.sql
```

Stop the system:

```
docker-compose down
```

Delete the old data:

```
docker volume rm nextcloud_db
```

Proceed to upgrade the PostgreSQL version in `db/Dockerfile`, then build and run:

```
docker-compose build
docker-compose up -d
```

Restore the data:

```
cat dump.sql | docker-compose run --rm db psql -h db -U postgres
```

## Backups

### Nextcloud backups

Set `$BACKUP_LOCATION` to the host directory that will receive the backup, then:

```
docker-compose exec -u www-data app /var/www/html/occ maintenance:mode --on
docker run --rm --volumes-from nextcloud_app_1 -v $BACKUP_LOCATION:/backup ubuntu bash -c "cd /var/www/html && tar cvf /backup/nextcloud-data-$(date +%Y%d%m).tar data"
docker-compose exec -u www-data app /var/www/html/occ maintenance:mode --off
```
