FROM debian:latest
WORKDIR /root
RUN apt-get update
RUN apt-get install -y clang make
