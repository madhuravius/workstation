#!/usr/bin/env bash

# Setup swap in the vm as it's not always enough for a small size when doing beefy ops.

swapsize=8000
grep -q "swapfile" /etc/fstab

if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi


