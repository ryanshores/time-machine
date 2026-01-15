FROM mbentley/timemachine

RUN apk update && \
    apk add --no-cache avahi avahi-tools dbus

COPY avahi/timemachine.service /etc/avahi/services/timemachine.service
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/init"]