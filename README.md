# docker-maven-dind

Maven with Docker-in-Docker (dind) support.

This image at the moment contains:

- `docker 1.11.2`
- `openjdk 8`
- `maven 3.3.9`

## Usage:

### Standalone

First start the DIND container:

```bash
docker run -it --privileged --name some-docker -d \
  docker:1.11.2-dind --insecure-registry=docker.infra.regis24.de
```

Then start up this image:

```bash
docker run -it --rm --link some-docker:docker \
  -e HTTP_PROXY=http://proxy.regis24.de:8080 \
  -e HTTPS_PROXY=http://proxy.regis24.de:8080 \
  -e NO_PROXY=docker,docker.infra.regis24.de \
  -v "$PWD":/usr/src/app
  -w /usr/src/app \
  dmvn /bin/sh
```

For maven builds, use this (an example):

```bash
docker run -it --rm --link some-docker:docker \
  -e HTTP_PROXY=http://proxy.regis24.de:8080 \
  -e HTTPS_PROXY=http://proxy.regis24.de:8080 \
  -e NO_PROXY=docker,docker.infra.regis24.de \
  -v "$PWD":/usr/src/app
  -w /usr/src/app \
  dmvn mvn -s .mvn-settings.xml clean verify -B
```
