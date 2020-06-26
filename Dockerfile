FROM rust AS librespot

RUN apt-get update \
  && apt-get -y install \
  build-essential \
  portaudio19-dev \
  curl \
  unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

RUN cd /tmp \
  && curl -sLO https://github.com/librespot-org/librespot/archive/master.zip \
  && unzip master.zip \
  && cd librespot-master \
  && cargo build --release \
  && chmod +x /tmp/librespot-master/target/release/librespot

FROM ubuntu

RUN apt-get update \
  && apt-get -y install \
  curl \
  libportaudio2 \
  libvorbis0a \
  libavahi-client3 \
  libflac8 \
  libvorbisenc2 \
  libvorbisfile3 \
  libopus0 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

ARG ARCH=amd64
ARG SNAPCAST_VERSION=0.20.0
ARG POSTFIX=-1

RUN curl -sL -o /tmp/snapserver.deb https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}${POSTFIX}_${ARCH}.deb \
  && dpkg -i /tmp/snapserver.deb \
  && rm /tmp/snapserver.deb

COPY --from=librespot /tmp/librespot-master/target/release/librespot /usr/local/bin/

EXPOSE 1704 1705 1780
ENTRYPOINT ["snapserver"]
