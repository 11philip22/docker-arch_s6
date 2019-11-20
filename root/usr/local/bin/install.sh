#! /bin/bash

echo -e "\e[32m[INFO] Unpacking s6 overlay \e[0m"
pacman -Sy tar --noconfirm
gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /
rm -rf /tmp/*

echo -e "\e[32m[INFO] Repairing symlink to bin \e[0m"
if [ ! -L "/bin" ]; then
  cd / || exit 1
  tar cf - bin | ( cd /usr || exit 1; tar xfp - )
  rm -rf -- bin/*
  rmdir bin
  ln -s /usr/bin bin
fi

echo -e "\e[32m[INFO] Cleanup build depandancies \e[0m"
pacman -Rs tar --noconfirm
pacman -Scc --noconfirm

echo -e "\e[32m[INFO] Creating user \e[0m"
useradd -u 1000 -U -d /home/user -m -s /sbin/nologin user

echo -e "\e[32m[INFO] Creating folders \e[0m"
mkdir -p /config /defaults

echo -e "\e[32m[INFO] Fixing permissions \e[0m"
chown -R user:user /config
chown -R user:user /defaults