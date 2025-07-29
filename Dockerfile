FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    x264 \
    x265 \
    mp4v2-utils \
    bc \
    git \
    sudo \
    ca-certificates \
    curl \
    mediainfo \
    libmp4v2-dev \
    autoconf \
    automake \
    libtool \
    g++ \
    make \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/KrumpetPirate/AAXtoMP3.git
RUN ln -s /opt/AAXtoMP3/AAXtoMP3 /usr/local/bin/aax-to-mp3

COPY run-aax.sh /usr/local/bin/run-aax
RUN chmod +x /usr/local/bin/run-aax

WORKDIR /working

ENTRYPOINT ["/bin/bash"]
