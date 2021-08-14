#! /usr/bin/env -S bash -ex

DRIVE="sdXDANGER"

for i in {1..10}; do
    echo -en "\n\nrun $i\n\n"
    echo $i >> current_iteration.txt
    date >> current_iteration.txt
    shred -vzf -n2 "/dev/${DRIVE}"
done

