# this dockerfile uses c dev env
# version 0.1

FROM ubuntu:18.04

MAINTAINER Hosea <starit@msn.cn>

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ADD sources.list /etc/apt/sources.list

## Tool
 RUN apt-get update && apt-get install -y \
         vim \
         wget \
         gcc \
         && rm -rf /var/lib/apt/lists/*

COPY .bashrc /root/

WORKDIR /root
