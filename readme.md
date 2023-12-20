# Workstation setup

Setting this up for replicable workstation anywhere.

This requires the following plugins: `vagrant-timezone` and `vagrant-disksize`.

```sh 
# needed for docker tz and other tz data to avoid defaulting to utc
vagrant plugin install vagrant-timezone
# needed for resizing disk
vagrant plugin install vagrant-disksize
```

Basic usage:

```sh
# spin it up
vagrant up

# use the box
vagrant ssh

# rebuild if needed 
vagrant reload --provision

# put it to sleep when done
vagrant suspend
```
