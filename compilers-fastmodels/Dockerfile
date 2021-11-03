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
ADD --chown=$USER:$USER FastModels_11-16-014_Linux64.tgz /home/$USER/tmp
ADD --chown=$USER:$USER install-fm.sh /home/$USER
RUN /home/$USER/install-fm.sh $USER
RUN sudo rm -rf /home/$USER/tmp
RUN sudo rm -rf /home/$USER/install-fm.sh
ADD --chown=$USER:$USER GDBRemoteConnection.so /home/$USER
ADD --chown=$USER:$USER GDBreadme.txt /home/$USER

# Arm Compiler 6 download file
ENV AC6=DS500-BN-00026-r5p0-19rel0.tgz

# Install Arm Compiler 6
RUN wget https://developer.arm.com/-/media/Files/downloads/compiler/$AC6
RUN mkdir /home/$USER/tmp
RUN tar xvfz $AC6  -C /home/$USER/tmp
RUN /home/$USER/tmp/install_x86_64.sh --i-agree-to-the-contained-eula --no-interactive -d /home/$USER/AC6
RUN rm -rf /home/$USER/tmp
RUN rm $AC6
ENV PATH "/home/$USER/AC6/bin:$PATH"

# Install Cortex-R and Cortex-M bare metal GNU tools
RUN wget -qO-  https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar xj
ENV PATH "/home/$USER/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"

# Install Cortex-A AArch64 bare metal GNU tools
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz | tar xJ
ENV PATH "/home/$USER/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin:$PATH"

# Modify the ARMLMD_LICENSE_FILE env var with your license server
ENV ARMLMD_LICENSE_FILE "7010@localhost"
ENV ARM_TOOL_VARIANT  "ult"

# environment
RUN echo ". /home/$USER/FM/FastModelsTools_11.16/source_all.sh" >> /home/$USER/.bashrc
RUN echo "set auto-load safe-path /" >> /home/$USER/.gdbinit
