# Minio CDN

A Dokku-deployable minio server, preconfigured to be served on port 80 as expected of Dokku applications.

# Deploying

On the Dokku server:

```shell
# create the app
dokku apps:create minio

# create requisite persistent storage
mkdir -p /var/lib/dokku/data/storage/minio
chown 32767:32767 /var/lib/dokku/data/storage/minio

# mount the storage
dokku storage:mount minio /var/lib/dokku/data/storage/minio:/app/storage

# set access key and secret key id for future access
dokku config:set minio MINIO_ACCESS_KEY="$(date | md5sum | cut -d' ' -f1 | cut -c1-20)"
dokku config:set minio MINIO_SECRET_KEY="$(sleep 1 && date | md5sum | cut -d' ' -f1)"
```

On your local computer:

```shell
# add the remote
git remote add dokku dokku@SERVER_IP:minio

# push the app
git push dokku master
```
