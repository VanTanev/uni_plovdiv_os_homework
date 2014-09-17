#!/bin/bash

set -e
#set -x

SOURCE=$1
DESTINATION=$2

main() {
    echo "New files copied: `copy_files_without_overwrite_and_return_num`"
    echo "Numeric copies of existing files added: `find_updated_files | wc -l`"
    create_new_for_updated
}

create_new_for_updated() {

    # Originally this had the form of:
    #
    # for source_file in `find_updated_files`; do
    #
    # however, it turns out that if you have a file with spaces in it
    # the for loop will receive each filepart separately ($IFS variable denotes
    # field separators, and the default is " ").
    # Instead, we just read the STDOUT from find_updated_files and manually separate at newline
    find_updated_files | while read -d $'\n' source_file; do
        base_filename=`basename -- "$source_file"`
        dirname=`dirname -- "$source_file"`
        extension="${base_filename##*.}"
        filename="${base_filename%.*}"

        # This is a very simplistic approach, but given that the task stipulated a number with
        # format 1,2..11,12...100,101 is inserted in the braces, this means we cannot use `sort`
        # to grab the latest file; The task also stipulated we cannot use update time, but instead
        # must use either size or contents to differentiate files, so I can't make use of a similar
        # function I wrote a while back:
        #
        # https://github.com/VanTanev/dotfiles2/blob/master/.functions#L48
        # get the latest file in a directory
        # function latest() {
        #   echo $1/$(ls -rt $1 |tail -1);
        # }
        #
        # therefore, I decided to just go with a "good enough" approach; Stating a file
        # to check for existance should be fast enough for most practical purposes
        for i in {1..1000}; do
            target_file="$filename($i).$extension"
            if [ ! -f "$DESTINATION/$dirname/$target_file" ]; then
                cp "$SOURCE/$source_file" "$DESTINATION/$dirname/$target_file"
                break
            fi
        done
    done
}

find_updated_files() {
    # we're using rsync's "-c" switch to perform a CRC comparison of files.
    # without it, rsync compares size and update time, which is a bit more error prone

    # as for the head/tail trick, I can't wrap my head around awk to use --list-files
    rsync -acnv -- $SOURCE/ $DESTINATION/ | tail -n +2 |head -n -3
}

copy_files_without_overwrite_and_return_num() {
    # cp's "-n" switch doesn't overwrite files with the same name
    cp -v -n -R -- $SOURCE/* $DESTINATION | wc -l
}

main
