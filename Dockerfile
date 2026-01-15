FROM mbentley/timemachine

RUN apt-get update && \
    apt-get install -y avahi-daemon avahi-utils dbus && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY avahi/timemachine.service /etc/avahi/services/timemachine.service

CMD ["/bin/bash", "-c", "dbus-daemon --system && avahi-daemon --no-chroot && /init"]