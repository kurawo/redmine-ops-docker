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

## When use self certificate on nginx container

containers down.

```
docker-compose down
```

ref: [nginx で オレオレ証明書をする https://qiita.com/snowdog/items/9c96ee0fa6ed096e8940](https://qiita.com/snowdog/items/9c96ee0fa6ed096e8940)

install openssl in Docker Host.

```
apt-get install openssl
```

create working directory.

```
mkdir /etc/nginx
mkdir /etc/nginx/ssl
```

create Private key.

```
openssl genrsa -out /etc/nginx/ssl/server.key 2048
```

```
openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr
```

enter server domain name (or fqdn) the commmon name.

create crt myself.

```
openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt
```

use branch https.

```
git pull origin https
```

or docker-compose.yml commentout and uncomment.

before:

```
  nginx:
    image: nginx:1.17.8
    [...]
    ports:
      - "80:80"
      #- "443:443"
```

after:

```
  nginx:
    image: nginx:1.17.8
    [...]
    ports:
      #- "80:80"
      - "443:443"
```

./nginx/nginx.conf commentout and uncomment.

before:

```
    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        # listen       443 ssl http2 default_server;
        # listen       [::]:443 ssl http2 default_server;
        client_max_body_size    4G;

        # ssl_certificate     /etc/nginx/ssl/server.crt;
        # ssl_certificate_key /etc/nginx/ssl/server.key;
```

after:

```
    server {
        #listen       80 default_server;
        #listen       [::]:80 default_server;
        listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        client_max_body_size    4G;

        ssl_certificate     /etc/nginx/ssl/server.crt;
        ssl_certificate_key /etc/nginx/ssl/server.key;
```

copy private key and crt from working directory.

```
cd redmine-ops-docker
cp /etc/nginx/ssl/server.crt ./nginx/ssl/
cp /etc/nginx/ssl/server.key ./nginx/ssl/
```

containers up.

```
docker-compose up -d
```