#!/bin/sh

cd ~/difuze/helper_scripts
python run_all.py -l $LLVM_BC_OUT -a $CHIPSET_NUM -m $MAKEOUT -g $COMPILER_NAME -n $ARCH_NUM -o $OUT -k $KERNEL_SRC_DIR -f $IOCTL_FINDER_OUT

cd post_processing
python run_all.py -f $IOCTL_FINDER_OUT -o $OUTPUT_DIR -n $DEVNAME_OPT -m $MULTI_DEVICE
