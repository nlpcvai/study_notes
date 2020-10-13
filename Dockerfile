FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04 

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV HTTP_PROXY "http://127.0.0.1:3213"
ENV HTTP_PROXYS "https://127.0.0.1:3213"
RUN rm /etc/apt/sources.list.d/cuda.list
#COPY 7fa2af80.pub 7fa2af80.pub
#RUN apt-key add 7fa2af80.pub
#RUN apt-get clean && \
#    cd /var/lib/apt && \
#    mv lists lists.old && \
#    mkdir -p lists/partial && \
#    apt-get clean
RUN touch /etc/apt/apt.conf.d/proxy.conf && \
    echo "Acquire::http::Proxy \"http://127.0.0.1:3213/\";" > /etc/apt/apt.conf.d/proxy.conf && \
    echo "Acquire::https::Proxy \"https://127.0.0.1:3213/\";" >> /etc/apt/apt.conf.d/proxy.conf && \
    echo "Acquire::ftp::Proxy \"ftp://127.0.0.1:3213/\";" >> /etc/apt/apt.conf.d/proxy.conf

RUN apt-get update && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    wget \
    git \
    vim \
    freeglut3-dev \
    python-opengl \
    libz-dev \
    libopenexr-dev \
    python3.8 \
    virtualenv \
    python3-pip \
    && apt-get clean && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python &&\
    ln -s /usr/bin/python3.8 /usr/local/bin/python3 &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -s /bin/bash -d /home/mason -m -G sudo mason
RUN echo 'mason:l' | chpasswd
RUN echo "root:l" | chpasswd

USER mason
WORKDIR /home/mason

RUN mkdir venvs && \
    cd venvs && \
    virtualenv torch_env --python=python3 && \
    . torch_env/bin/activate && \
    pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com torch torchvision

