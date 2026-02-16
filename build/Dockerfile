# Global build arguments
ARG ENTRYPOINTS_VERSION=2.0.0
ARG ALPINE_VERSION=3.23.3

# Stage to fetch scripts from the versioned entrypoints asset image
FROM ghcr.io/coolcow/entrypoints:${ENTRYPOINTS_VERSION} AS entrypoints

# Main build stage
FROM alpine:${ALPINE_VERSION}

ENV PROFILE_NAME=default \
    LOCAL_IP=127.0.0.1 \
    WAIT_AFTER_START=10 \
    RECONNECT_IF_NOT= \
    RECONNECT_IF_NOT_INTERVAL=10

RUN apk --no-cache --update add \
      iproute2 \
      shadow \
      strongswan \
      su-exec

COPY --from=entrypoints /assets/create_user_group_home.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_su-exec.sh /usr/local/bin/

COPY charon-logging.conf /etc/strongswan.d/charon-logging.conf
COPY entrypoint.sh /usr/local/bin/
COPY cmd.sh /cmd.sh

RUN chmod +x /usr/local/bin/*.sh /cmd.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="GPL-3.0"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/strongswan-client"
ARG LABEL_DESCRIPTION="Simple Alpine-based strongSwan client image."
ARG LABEL_URL="https://ghcr.io/coolcow/strongswan-client"
ARG LABEL_VCS_URL="https://github.com/coolcow/docker-strongswan-client"
ARG LABEL_MAINTAINER="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>"

LABEL org.opencontainers.image.title=$LABEL_IMAGE_NAME \
      org.opencontainers.image.description=$LABEL_DESCRIPTION \
      org.opencontainers.image.version=$LABEL_VERSION \
      org.opencontainers.image.created=$LABEL_BUILD_DATE \
      org.opencontainers.image.revision=$LABEL_VCS_REF \
      org.opencontainers.image.authors=$LABEL_MAINTAINER \
      org.opencontainers.image.licenses=$LABEL_LICENSE \
      org.opencontainers.image.source=$LABEL_VCS_URL \
      org.opencontainers.image.url=$LABEL_URL