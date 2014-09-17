#!/bin/bash

set -e

SOURCE=$1
DESTINATION=$2

main() {
    copy_files_without_overwrite
}

copy_files_without_overwrite() {
    cp -n -R $SOURCE/* $DESTINATION
}

main
