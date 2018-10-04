# Superproxy


#### Create data volume

```

docker volume create --name app-data
docker network create --attachable app-data

```


#### Start application

```

docker-compose build
docker-compose up

```


#### Replicate existing local db to our app-data volume

```

curl -X POST 'http://admin:pass@localhost:5984/_replicate' -H 'Content-type: application/json' -d '{"source":"xyz", "target":"http://admin:pass@localhost/xyz"}'


```

#### Misc

```

# Remove exited containers
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm

```
