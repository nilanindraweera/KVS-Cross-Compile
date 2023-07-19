# syntax=docker/dockerfile:1
FROM axisecp/acap-sdk:3.3-armv7hf-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y \
    liblog4cplus-dev \
	libssl-dev \
	libcurl4-openssl-dev \
	libgtest-dev \
    ssh \
    sshpass \
	cmake \
    pkg-config \
    m4 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
CMD /bin/bash