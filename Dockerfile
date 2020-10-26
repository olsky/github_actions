FROM ubuntu:20.04

LABEL Description="Docker for arm-gcc-embedded projects"

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

ENV DISTRIB_CODENAME bionic



RUN sudo apt-get update -y
RUN apt-get install -y  cmake  make  automake  python-setuptools  ninja-build  python-dev  libffi-dev  libssl-dev  software-properties-common python-software-properties
RUN apt-get -y upgrade

# 9-2020-q2-update
RUN wget -q -P $HOME/gnuarmemb https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
RUN cd $HOME/gnuarmemb && tar xjf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

RUN export PATH=$PATH:$HOME/gnuarmemb/gcc-arm-none-eabi-9-2020-q2-update/bin

COPY build $HOME/entrypoint_builder.sh

ENTRYPOINT ["$HOME/entrypoint_builder.sh"]
