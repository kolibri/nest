#!/bin/bash

set -e

if [ $# -lt 1 ]
then
    echo "Usage : $0 tasks [extra options]"
    exit
fi

SCRIPT="scripts/$1.sh"

if [ ! -f $SCRIPT ]
then
    echo "Script ${SCRIPT} does not exist"
    exit
fi

source $SCRIPT ${@:2}

set +e
