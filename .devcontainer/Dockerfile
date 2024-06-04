ARG GO_VERSION=1.22
FROM golang:${GO_VERSION}-bullseye
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN   apt-get update -y
RUN apt-get install python3 && ln -sf python3 /usr/bin/pyppthon
RUN apt-get install python3-pip -y \
    && apt-get install -y sudo \
    vim \
    make
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip install pre-commit

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt install wget git make
RUN wget https://github.com/sigstore/gitsign/releases/download/v0.10.1/gitsign_0.10.1_linux_amd64 && \
    chmod +x gitsign_0.10.1_linux_amd64 && \
    mv ./gitsign_0.10.1_linux_amd64 /usr/bin/gitsign

# Setup shell
USER vscode