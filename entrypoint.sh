#!/bin/sh
set -e

# Start system dbus (required for avahi)
dbus-daemon --system

# Start avahi in foreground mode-safe background
avahi-daemon --no-chroot &

# Exec the original init (Samba / Time Machine)
exec "$@"