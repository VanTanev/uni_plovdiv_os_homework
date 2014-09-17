#!/bin/bash

set -e

bash fixture.sh

error() {
    echo FAIL: $*
    exit 1
}


(
    cd sandbox
    sh special_copy.sh source dest
    [ -f dest/new_file.txt ] || error "It does not copy over the new file"
    [ "`cat dest/existing_file.txt`" == "original" ] || error "Existing file in dest are kept"
    [ -f "dest/existing_file_diff_size(1).txt" ] || error "Exisitng files are not added to"
    echo OK!
)
