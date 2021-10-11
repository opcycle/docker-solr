# Apache Solr Docker Container Image

[![Docker Stars](https://img.shields.io/docker/stars/opcycle/solr.svg?style=flat-square)](https://hub.docker.com/r/opcycle/solr) 
[![Docker Pulls](https://img.shields.io/docker/pulls/opcycle/solr.svg?style=flat-square)](https://hub.docker.com/r/opcycle/solr)

#### Docker Images

- All images based on Fedora Linux
- [GitHub actions builds](https://github.com/opcycle/solr/actions) 
- [Docker Hub](https://hub.docker.com/r/opcycle/solr)


#### Environment Variables
When you start the Solr image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line. The following environment values are provided to custom Solr:

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `JAVA_ARGS`               |               |                                 |
| `SOLR_PORT`               | `8080`        |                                 |

#### Config sets

#### Persisting Solr data
If you remove the container all your data and configurations will be lost, and the next time you run the image the database will be reinitialized. To avoid this loss of data, you should mount a volume that will persist even after the container is removed.
For persistence you should mount a volume at the `/opt/solr/data/cores` path. The above examples define a docker volume namely solr_data. The Solr application state will persist as long as this volume is not removed.
To avoid inadvertent removal of this volume you can mount host directories as data volumes. Alternatively you can make use of volume plugins to host the volume data.

#### Run the Service

```bash
docker service create --name solr \
  -p 8080:8080 \
  -e JAVA_ARGS="-Xms2G -Xmx31G" \
  --mount type=bind,source=/data/cores,destination=/opt/solr/data/cores \
  opcycle/solr:8.2.0
```

```bash
docker stack deploy -c solr-stack.yml
```

```
version: "3.8"
services:
  solr:
    image: opcycle/solr:8.2.0
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      env:
        JAVA_ARGS: -Xms2G -Xmx31G
```


# Contributing
We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/opcycle/docker-solr/issues), or submit a [pull request](https://github.com/opcycle/docker-solr/pulls) with your contribution.

# Issues
If you encountered a problem running this container, you can file an issue. For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version (docker version)
- Output of docker info
- Version of this container
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)

# License
Copyright 2016-2021 OpCycle

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.