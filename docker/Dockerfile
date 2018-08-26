FROM ubuntu:16.04
ENTRYPOINT ["/root/run.sh"]

RUN apt-get -y update
RUN apt-get -y install git bzip2 make libxml2-dev python cmake g++ libglib2.0-0 libgl1 bc pkg-config python-lxml

RUN cd && git clone -b kahiroka-sandbox https://github.com/kahiroka/difuze.git
RUN cd ~/difuze/helper_scripts && python setup_difuze.py -o difuze_deps
ENV LLVM_ROOT /root/difuze/helper_scripts/difuze_deps/llvm/build
ENV PATH $LLVM_ROOT/bin:/root/difuze/helper_scripts/difuze_deps/sparse:$PATH
RUN cd ~/difuze/InterfaceHandlers && ./build.sh

COPY run.sh /root/
