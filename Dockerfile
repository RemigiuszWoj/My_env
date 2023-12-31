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
    git \
    libncursesw5-dev \
    net-tools \
    vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /etc/apt/sources.list.d/* /etc/apt/sources.list /etc/apt/preferences /var/cache/apt/archives/*.deb

# Env chane for PyEnv
ENV DEBIAN_FRONTEND=noninteractive  
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
#Pythone version
ENV PYTHON_VERSION 3.7.10
ENV HOSTNAME dev_env

# Install pyenv
RUN set -ex && \
    curl https://pyenv.run | DEBIAN_FRONTEND=noninteractive bash && \
    pyenv update && \
    pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    pyenv rehash

RUN pip install --upgrade pip
# Create workdir
RUN mkdir /workdir
WORKDIR /workdir

EXPOSE 8080
EXPOSE 22

# ADD data and apps folders
COPY ./data /workdir/data
COPY ./apps /workdir/apps

# Add hostname

# Create hostname dir
RUN mkdir ${HOSTNAME}
# Run sample apps
RUN ./apps/script.py
