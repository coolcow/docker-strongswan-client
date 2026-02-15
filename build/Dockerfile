FROM alpine

ENV PROFILE_NAME=default \
    LOCAL_IP=127.0.0.1 \
    WAIT_AFTER_START=10 \
    RECONNECT_IF_NOT= \
    RECONNECT_IF_NOT_INTERVAL=10

RUN apk add --no-cache --update strongswan

COPY charon-logging.conf /etc/strongswan.d/charon-logging.conf
COPY cmd.sh /cmd.sh

RUN chmod +x /cmd.sh

CMD ["/cmd.sh"]