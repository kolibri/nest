# How to reinstall archlinux x64

## Create bootable micro sd card

### on ArchLinux

- `./scripts/arch_arm/install_card.sh` follow instructions
- insert card into raspberry pi and boot

## After booting

On controll machine:
- `ssh-copy-id alarm@IP-ADDRESS` (password is `alarm`)
- `ssh alarm@IP-ADDRESS 'su root -c "pacman -S --noconfirm python2 sudo"' (password is `root`)
- adjust IP-adress in `inventory/real/hosts`
- `ansible-playbook -i inventory/real/hosts  -l cloud.ko -u alarm -t init -K --become-method=su site.yml` (SU password: `root`)

After this:
- `ansible-playbook -i inventory/real/hosts  -l cloud.ko site.yml`

