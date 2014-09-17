#!/bin/bash
set -e


if [ -e sandbox ]; then
    rm -rf sandbox
fi

mkdir sandbox

cp -R fixtures/* sandbox/

ln -s ../../special_copy.sh sandbox
