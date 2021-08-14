#! /usr/bin/env -S bash -e

#drive="/dev/sdd2"
drive="/dev/mapper/croot"

if ! [ -z ${1} ]; then
    drive=${1}
fi

function benchmark_cryptsetup {
    local num_runs=${1}

    for i in $(seq ${num_runs}); do
        echo -en "\n> cryptsetup benchmark $i/${num_runs}:\n\n"

        for cipher in "xchacha12,aes-adiantum-plain64" "xchacha20,aes-adiantum-plain64" "aes-xts-plain64"; do
            cryptsetup benchmark --cipher="${cipher}";
        done
    done

    echo -en "\n> cryptsetup benchmark done!\n\n\n"
}

function benchmark_dd {
    local bs=${1}
    local count=${2}
    local num_runs=${3}

    rm deleteme.img 2> /dev/null || true

    for i in $(seq ${num_runs}); do
        echo -en "\n> dd benchmark ${i}/${num_runs} (bs=${bs}):\n"

        echo -en "\nwrite test:\n"
        sudo sync
        sudo bash -c "echo '3' > /proc/sys/vm/drop_caches"
        sudo dd if=/dev/zero of=deleteme.img bs=${bs} count=${count} oflag=dsync status=progress 2>&1

        echo -en "\nread test:\n"
        sudo sync
        sudo bash -c "echo '3' > /proc/sys/vm/drop_caches"
        sudo dd if=deleteme.img of=/dev/null bs=${bs} oflag=dsync status=progress 2>&1
        sudo rm deleteme.img
    done

    echo -en "\n> dd benchmark done!\n\n\n"
}

function benchmark_hdparm {
    local bench_drive=${1}
    local num_runs=${2}

    for i in $(seq ${num_runs}); do
        echo -en "\n> hdparm benchmark ${i}/${num_runs} (${bench_drive}):\n\n"
        sudo hdparm --direct -Tt ${bench_drive} 2>&1
    done

    echo -en "\n> hdparm benchmark done!\n\n"
}

# Let's go
echo -en "\nPlease make sure your working dir is on the drive to be benchmarked!\n\n"

benchmark_cryptsetup 1
benchmark_hdparm ${drive} 2
benchmark_dd 512M $((1024/512)) 1
benchmark_dd 128M $((1024/128)) 1
benchmark_dd 64M $((1024/64)) 1
benchmark_dd 32M $((1024/32)) 1
benchmark_dd 1M $((1024/4)) 1
benchmark_dd 64k $((1024*16/5)) 1
benchmark_dd 4k $((1024*16*4/25)) 1

