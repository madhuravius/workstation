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

# reload it to mount relative dirs
vagrant reload

# use the box (with display for clipboard support)
vagrant ssh -- -X

# rebuild if needed 
vagrant reload --provision

# put it to sleep when done
vagrant suspend
```

## Common Issues

Daily reboots are required for some reason or system clock will drift (ex: putting host to sleep and waking it up 3 days later).

SSH with `-- -X` and you will have access to clipboard for common copy pasting activities (ex: nvim).

