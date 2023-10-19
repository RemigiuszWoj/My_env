# Base
FROM ubuntu:latest as compilesys

# Initial config
LABEL maintainer="remigiusz.wojewodzki@gmail.com"
LABEL name="me_env"
USER root

# # Install dependencies, Pyenv, and configure
# RUN apt-get update && apt-get install -y python3 python3-pip git curl make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev
# RUN curl https://pyenv.run | bash
# RUN echo 'export PYENV_ROOT="/root/.pyenv"' >> ~/.bashrc
# RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
# RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
# RUN /bin/bash -c "source ~/.bashrc"

# # Install Python and create virtual environment
# RUN /bin/bash -c "source ~/.bashrc && apt-get upgrade && pyenv install 3.12.0 && pyenv virtualenv 3.12.0 my-env"

# # Set up the workspace
# VOLUME ["/home/data", "/home/apps"]
# CMD ["bash", "-c", "source ~/.bashrc && pyenv init - && /bin/bash"]
# WORKDIR /home/work

# ENV PYTHON_VERSION 2.7.10

WORKDIR /
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev \
        git 

RUN git clone https://github.com/pyenv/pyenv.git /pyenv
ENV PYENV_ROOT /pyenv
RUN /pyenv/bin/pyenv install 3.10.10
RUN eval "$(/pyenv/bin/pyenv init -)" && /pyenv/bin/pyenv local 3.10.10 && pip install numpy poetry setuptools wheel six auditwheel

# WORKDIR /
# COPY .git myproject.git
# RUN git clone myproject.git
# WORKDIR /myproject

RUN mkdir -p .venv
RUN eval "$(/pyenv/bin/pyenv init -)" && /pyenv/bin/pyenv local 3.10.10

FROM ubuntu:latest as targetsys
RUN useradd -m -u 1000 -U remigiusz
USER remigiusz

COPY --from=compilesys /pyenv /pyenv
