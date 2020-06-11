# how to use redmine docker-compose

## Summary

This binary's purpuse is IaC operation by docker.

Execution by this binary:

- Use redmine by docker-compose.
- Backup postgres and redmine's file by cron.
- Backup file delete 5 days later.
- Inject postgresql.conf.

## docker install

by yourself.

## git clone

```
git clone https://github.com/kurawo/redmine-ops-docker.git
```

## env file add

```
cd redmine-ops-docker/
```

```
vi env/posgres.env
```

```
POSTGRES_PASSWORD=changepass1
POSTGRES_DATABASE=redmine
POSTGRES_ROOT_PASSWORD=changepass2
POSTGRES_USER=redmine
TZ=Asia/Tokyo
```

```
vi env/redmine.env
```

```
REDMINE_DB_POSTGRES=postgres
REDMINE_DB_DATABASE=redmine
REDMINE_DB_USERNAME=redmine
REDMINE_DB_PASSWORD=changepass1
TZ=Asia/Tokyo
```

## chmod exec

```
sh chmod.sh 
```

## docker-compose up

```
docker-compose up -d
```

## stop docker-compose

```
docker-compose down
```