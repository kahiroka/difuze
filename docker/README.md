# Build your DIFUZE container

    $ docker build -t difuze/docker .

# Prepare your kernel and makeout.txt

In case of MediaTek kernel(33.2.A.3.123.tar.bz2), its directory structure is as below.

    ~/mediatek_kernel/build cmd.txt
    ~/mediatek_kernel/env.sh
    ~/mediatek_kernel/external/
    ~/mediatek_kernel/frameworks/
    ~/mediatek_kernel/kernel-3.18/
    ~/mediatek_kernel/kernel-3.18/makeout.txt
    ~/mediatek_kernel/kernel-3.18/out/
    ~/mediatek_kernel/prebuilts/
    ~/mediatek_kernel/vendor/

Current DIFUZE requres all ioctl function names must be unique, so you need to apply mtk-unique-ioctl.patch to the kernel source before build.

    $ ~/mediatek_kernel$ patch -p1 < mtk-unique-ioctl.patch

# Analyze your kernel drivers

Run the container with proper environment variables so that same path is used on both the container and the host.

    $ docker run --rm -it \
        --name=difuze \
        -e LLVM_BC_OUT=/home/${USER}/mediatek_kernel/llvm_bitcode_out \
        -e CHIPSET_NUM=1 \
        -e MAKEOUT=/home/${USER}/mediatek_kernel/kernel-3.18/makeout.txt \
        -e COMPILER_NAME=aarch64-linux-android-gcc \
        -e ARCH_NUM=2 \
        -e OUT=/home/${USER}/mediatek_kernel/kernel-3.18/out \
        -e KERNEL_SRC_DIR=/home/${USER}/mediatek_kernel/kernel-3.18 \
        -e IOCTL_FINDER_OUT=/home/${USER}/mediatek_kernel/ioctl_finder_out \
        -e OUTPUT_DIR=/home/${USER}/mediatek_kernel/post_process_out \
        -e DEVNAME_OPT=auto \
        -e MULTI_DEVICE=0 \
        -v /home/${USER}/mediatek_kernel:/home/${USER}/mediatek_kernel \
        difuze/docker

Outputs for MangoFuzz are generated in ~/mediatek_kernel/post_process_out on the host.
