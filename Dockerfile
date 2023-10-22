# Base image
FROM ubuntu:20.04

# base konfiguration
LABEL maintainer="remigiusz.wojewodzki@gmail.com"
LABEL name="me_env"

# Pyenv adons
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    ca-certificates \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    mecab-ipadic-utf8 \
    git \
    libncursesw5-dev

# Env chane for PyEnv
ENV DEBIAN_FRONTEND=noninteractive  
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#Pythone version
ENV PYTHON_VERSION 3.7.10

# Install pyenv
RUN set -ex && \
    curl https://pyenv.run | DEBIAN_FRONTEND=noninteractive bash && \
    pyenv update && \
    pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    pyenv rehash

# Create workdir
RUN mkdir /workdir
WORKDIR /workdir

# ADD data and apps folders
ADD ./data /workdir/data
ADD ./apps /workdir/apps

# Add hostname
ENV HOSTNAME dev_env

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    net-tools \
    vim

# #  Set statik ip
# RUN mkdir /etc/network
# RUN touch /etc/network/interfaces
# RUN echo "auto eth0" >> /etc/network/interfaces
# RUN echo "iface eth0 inet static" >> /etc/network/interfaces
# RUN echo "address 192.168.1.10" >> /etc/network/interfaces
# RUN echo "netmask 255.255.255.0" >> /etc/network/interfaces
# RUN echo "gateway 192.168.1.1" >> /etc/network/interfaces

# RUN ifdown eth0
# RUN ifup eth0

# To do do 
# dodanie sieci  docker compouse montowanie volumenow