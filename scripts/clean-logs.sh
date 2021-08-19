#! /usr/bin/env -S bash -ex

for i in ./logs-new/raw/newtest-*; do grep -Ev '(^.+ records .+$|^.+ copied, .+ copied, .+$|^.+benchmark done.+$|^.*Please make sure.+$|^$|^.*Inappropriate ioctl.*$)' "$i" > "./logs-new/cleaned/$(basename $i)"; done

