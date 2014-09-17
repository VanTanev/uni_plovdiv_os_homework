#!/bin/bash

set -e

SOURCE=$1
DESTINATION=$2

main() {
    copy_files
}

copy_files() {
    (
        cd $SOURCE
        cp -n -R $SOURCE/* $DESTINATION
    )
}

main
