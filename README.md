



# OLD README. Will be updated during reboot process..
---
---

# Nest

This is the base repo for my provision scripts.

Use it for inspiration or something like that.

(You also welcome to make suggestions)

## Docs
- [(re)Install Archlinux (x64)](docs/install_archlinux_x64.md)
- [(re)Install Archlinux (arm)](docs/install_archlinux_arm.md)
- [Description of hosts](docs/hosts.md)


## Status (what is covered by this repo aka 'my little todo list')

- [x] Install & provision Archlinux on a Thinkpad T420s
- [x] Install & provision Archlinux on a raspberry pi 2
- [ ] Auto-Provisioning
- [ ] Provision macOS


## Nest?

The metapher is about a birds nest. Birds lay eggs (like you may create new machines), they hatch it (like you provision your machines), and they teach the little birds to fly (like you throw you machines agains a wall, when they don't do, what you think you told them)

Yeah, I like birds!


# Setup new host

## Archlinux

download image: https://www.archlinux.org/download/

create usb boot drive: `sudo dd if=archlinux-2019.08.01-x86_64.iso of=/dev/sdXXX status=progress bs=4M`

boot

On managed system:

```bash
loadkeys de
systemctl start sshd.service
passwd # create password for root to enable ssh.
```

On control system:

```bash
ssh-copy-id root@NEW-HOST
ssh root@NEW-HOST 'bash -s' < scripts/arch_x64/install.sh
