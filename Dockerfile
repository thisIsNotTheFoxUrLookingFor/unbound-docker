FROM debian:bookworm-slim AS build

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -yq \
  && apt-get -yq install flex bison byacc make gcc libssl-dev libevent-dev libexpat-dev libnghttp2-dev net-tools git dnsutils htop wget curl \
  && git clone https://github.com/NLnetLabs/unbound.git && cd unbound && git checkout branch-1.20.0 \
  && ./configure --with-libnghttp2 --with-libevent && make && make install && ldconfig && adduser --disabled-password --gecos "" --home /dev/null unbound \
  && touch /usr/local/etc/unbound/unbound.log && chown unbound:unbound /usr/local/etc/unbound/unbound.log

WORKDIR /scripts

COPY scripts /scripts

RUN chmod 555 /scripts/start.sh

CMD /scripts/start.sh
