FROM amd64/ubuntu:18.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# general setup
RUN apt-get update && \
   apt-get -y install vim wget sudo git make cmake lsb-core libx11-dev libxext6 libsm6 libxcursor1 libxft2 libxrandr2 libxt6 libxinerama1 libz-dev lsb xterm telnet dos2unix iproute2 && \
    apt-get clean

# User account
ENV USER=ubuntu

# Setup default user
RUN useradd --create-home -s /bin/bash -m $USER && echo "$USER:ubuntu" | chpasswd && adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/$USER
USER $USER

# install Fast Models
RUN mkdir /home/$USER/tmp
RUN mkdir /home/$USER/FM
ADD --chown=$USER:$USER FastModels_11-14-021_Linux64.tgz /home/$USER/tmp
ADD --chown=$USER:$USER install-fm.sh /home/$USER
RUN /home/$USER/install-fm.sh $USER
RUN sudo rm -rf /home/$USER/tmp
RUN sudo rm -rf /home/$USER/install-fm.sh

# Modify the ARMLMD_LICENSE_FILE env var with your license server
ENV ARMLMD_LICENSE_FILE "7010@localhost"
ENV ARM_TOOL_VARIANT  "ult"

# environment
RUN echo ". /home/$USER/FM/FastModelsTools_11.14/source_all.sh" >> /home/$USER/.bashrc
