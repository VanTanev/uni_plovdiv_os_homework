#!/bin/bash

set -e

bash fixture.sh

error() {
    echo FAIL: $*
    exit 1
}

(
    cd sandbox
    bash special_copy.sh source dest
    [ -f dest/new_file.txt ] || error "It does not copy over the new file"
    [ "`cat "dest/-?*wtf.txt"`" == "weird" ] || error "it deals with strange filenames"
    [ "`cat "dest/existing_file_unchanged.txt"`" == "original" ] || error "Unchanged existing file in dest are kept as is"
    [ "`cat "dest/existing_file_updated.txt"`" == "original" ] || error "Changed existing file in dest are kept as is"
    [ "`cat "dest/existing_file_updated(1).txt"`" == "updated" ] || error "Existing updated files are added as a new file"
    [ "`cat "dest/subdir/existing_file_updated(1).txt"`" == "updated" ] || error "Existing updated files are added as new in subdirs"
    [ "`cat "dest/existing_file with spaces updated(1).txt"`" == "updated" ] || error "It works with files with spaces"
    [ "`cat "dest/multiple_copies(2).txt"`" == "updated2" ] || error "It deals with multiple updates of the same file"
    [ "`cat "dest/-?*wtfz(1).txt"`" == "weirdx2" ] || error "it deals with strange filenames on updated"
    echo OK!
)
