#!/bin/bash

LOGDIR="`dirname $0`/logs"
mkdir -p ${LOGDIR}
ansible-playbook -i inventory/real/hosts site.yml > "${LOGDIR}/`date "+%Y-%m-%d_%H-%M-%S"`.log"
find ${LOGDIR} -mtime +30 -type f -delete
