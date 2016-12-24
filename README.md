# Nest

## How to reinstall archlinux

###Create bootable usb stick

- [http://mirror.netcologne.de/archlinux/iso/latest/](Download archlinux iso)

#### on Osx

- `./scripts/arch/create-usb-stick-on-osx.sh` follow instructions

### Step trough installation

On target machine
- insert boot media, boot from it
- `loadkeys de-latin1`
- `passwd` for root password
- check `etc/ssh/sshd_config` for `PermitRootLogin yes`
- `systmctl start sshd.service`
- ensure network connection (`wifi-menu`)

On controll machine:
- `ssh-copy-id root@IP-ADDRESS`
- `ssh root@IP-ADDRESS 'bash -s' < scripts/arch/install.sh`

On target machine:
- `reboot`
Then:
- ensure network connection (`wifi-menu`)

On controll machine:
- adjust IP-adress in `inventory/real/hosts`
- `ssh-copy-id root@IP-ADDRESS` (password is `root`)
- `!> ansible-playbook -i inventory/real/hosts  -l cid.ko -u root -t init site.yml`
After this, drop `-u root` and `-t init`
- `ansible-playbook -i inventory/real/hosts  -l cid.ko site.yml`

If starting of thinkfan service is failing on first attempt, try `reboot`ing target machine and repat provisioning.

#### Post install steps:

- Remove obsolete configs from `etc/netctl`
