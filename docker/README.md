# Build your DIFUZE container

    $ docker build -t difuze/docker .

# Prepare your kernel and makeout.txt

In case of MediaTek kernel(33.2.A.3.123.tar.bz2), its directory structure is as below.

    ~/src/mediatek_kernel/build cmd.txt
    ~/src/mediatek_kernel/env.sh
    ~/src/mediatek_kernel/external/
    ~/src/mediatek_kernel/frameworks/
    ~/src/mediatek_kernel/kernel-3.18/
    ~/src/mediatek_kernel/kernel-3.18/makeout.txt
    ~/src/mediatek_kernel/kernel-3.18/out/
    ~/src/mediatek_kernel/prebuilts/
    ~/src/mediatek_kernel/vendor/

Current DIFUZE requres all ioctl function names must be unique, so you need to apply mtk-unique-ioctl.patch to the kernel source before build.

    $ ~/src/mediatek_kernel$ patch -p1 < mtk-unique-ioctl.patch

# Analyze your kernel drivers

Run the container with proper environment variables.

    $ docker run -it \
        --name=difuze \
        -e LLVM_BC_OUT=/root/work/llvm_bitcode_out \
        -e CHIPSET_NUM=1 \
        -e MAKEOUT=/root/work/kernel-3.18/makeout.txt \
        -e COMPILER_NAME=aarch64-linux-android-gcc \
        -e ARCH_NUM=2 \
        -e OUT=/root/work/kernel-3.18/out \
        -e KERNEL_SRC_DIR=/root/work/kernel-3.18 \
        -e IOCTL_FINDER_OUT=/root/work/ioctl_finder_out \
        -e OUTPUT_DIR=/root/work/post_process_out \
        -e DEVNAME_OPT=auto \
        -e MULTI_DEVICE=0 \
        -v ~/src/mediatek_kernel:/root/work \
        difuze/docker

Outputs for MangoFuzz are generated in ~/src/mediatek_kernel/post_process_out on the host.
