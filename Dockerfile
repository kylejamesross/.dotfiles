FROM ubuntu:latest
RUN apt update -y
RUN apt install -y git
RUN apt install -y python3
RUN apt-get update && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install ansible
