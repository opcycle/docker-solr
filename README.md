# Apache Solr Docker Container Image

[![Docker Stars](https://img.shields.io/docker/stars/opcycle/solr.svg?style=flat-square)](https://hub.docker.com/r/opcycle/solr) 
[![Docker Pulls](https://img.shields.io/docker/pulls/opcycle/solr.svg?style=flat-square)](https://hub.docker.com/r/opcycle/solr)

#### Docker Images

- All images based on Fedora Linux
- [GitHub actions builds](https://github.com/opcycle/solr/actions) 
- [Docker Hub](https://hub.docker.com/r/opcycle/solr)

#### Supported versions
- Solr 8.2
- Solr 8.3
- Solr 8.4
- Solr 8.5
- Solr 8.6
- Solr 8.7
- Solr 8.8
- Solr 8.9
- Solr 8.10

#### Environment Variables
When you start the Solr image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line. The following environment values are provided to custom Solr:

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `JAVA_ARGS`               |               | Configure JVM params            |
| `SOLR_PORT`               | `8080`        | Listen port                     |

#### Config sets

Configsets are a set of configuration files used in a Solr installation: `solrconfig.xml`, the schema, and then resources like language files, `synonyms.txt`, DIH-related configuration, and others that are referenced from the config or schema.

Such configuration, configsets, can be named and then referenced by collections or cores, possibly with the intent to share them to avoid duplication.
Solr ships with two example configsets located in `server/solr/configsets`, which can be used as a base for your own.

#### Persisting Solr data
If you remove the container all your data and configurations will be lost, and the next time you run the image the database will be reinitialized. To avoid this loss of data, you should mount a volume that will persist even after the container is removed.

For persistence you should mount a volume at the `/opt/solr/data/cores` path. The above examples define a docker volume namely `solr_data`. The Solr application state will persist as long as this volume is not removed.

To avoid inadvertent removal of this volume you can mount host directories as data volumes. Alternatively you can make use of volume plugins to host the volume data.

#### Run the Service

```bash
docker service create --name solr \
  -p 8080:8080 \
  -e JAVA_ARGS="-Xms2G -Xmx31G" \
  --mount type=bind,source=/data/solr,destination=/opt/solr/data/cores \
  opcycle/solr:8.2
```

When running Docker Engine in swarm mode, you can use `docker stack deploy` to deploy a complete application stack to the swarm. The deploy command accepts a stack description in the form of a Compose file.

```bash
docker stack deploy -c solr-stack.yml solr
```

Compose file example:
```
version: "3.8"
services:
  solr:
    image: opcycle/solr:8.2
    ports:
      - 8080:8080
    volumes:
      - solr_data:/opt/solr/data/cores
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      env:
        JAVA_ARGS: -Xms2G -Xmx31G

volumes:
  solr_data:
    driver: local
    driver_opts:
      type: "none"
      o: "bind"
      device: "/data/solr"
```


# Contributing
We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/opcycle/docker-solr/issues), or submit a [pull request](https://github.com/opcycle/docker-solr/pulls) with your contribution.

# Issues
If you encountered a problem running this container, you can file an [issue](https://github.com/opcycle/docker-solr/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version
- Output of docker info
- Version of this container
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)
