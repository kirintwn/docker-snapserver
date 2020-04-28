## About

🐳 [snapcast server](https://github.com/badaix/snapcast) Docker image based on Ubuntu. <br/>
Image on [DockerHub](https://github.com/kirintwn/docker-snapserver)

___

- [About](#about)
- [Quick Start](#quick-start)
  - [Docker](#docker)

## Quick Start

### Docker

```
$ docker run \
  --rm \
  -p 1704:1704 \
  -p 1705:1705 \
  -p 1780:1780 \
  kirintwn/snapserver:latest \
  "--stream.stream=spotify:///librespot?name=spotify&username=${SPOTIFY_USERNAME}&password=${SPOTIFY_PASSWORD}"
```

Or you can use the [docker-compose.yaml](./docker-compose.yaml) to start the server.
Remember to set environment variables `SPOTIFY_USERNAME` and `SPOTIFY_PASSWORD`.

```
docker-compose up -d
docker-compose logs -f
```
