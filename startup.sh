#!/bin/bash
#
# Preconfigure the booted docker image with SSH keys
#

set -x

USER=$1

if [ -z "$PUB_KEYS" ]; then
  echo "You need to set your public key in PUB_KEYS environment variable"
  exit 10
fi

mkdir -p /home/$USER/.ssh
echo $PUB_KEYS > /home/$USER/.ssh/authorized_keys
chown $USER /home/$USER/.ssh/authorized_keys

echo "SSH Keys activated... booting!"


[[ -d /home/$USER/.weechat ]] || mkdir /home/$USER/.weechat

chown -R $USER /home/$USER/.weechat

export LC_ALL=en_US.UTF-8
/usr/sbin/sshd -D
