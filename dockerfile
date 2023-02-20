FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

RUN apt-get update; apt-get -y install curl

RUN apt-get install -y build-essential git clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev

RUN git clone https://github.com/YosysHQ/yosys.git yosys

RUN cd yosys; make -j$(nproc); make install

WORKDIR "/project/"
ENTRYPOINT [ "/bin/bash", "-c", "yosys src/synth/synth.ys > build/logs/syn_log.txt" ]
