FROM amd64/ubuntu:18.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# general setup
RUN apt-get update && \
    apt-get -y install vim wget curl sudo git unzip bzip2 make cmake lsb-core libx11-dev libxext6 libsm6 libxcursor1 libxft2 libxrandr2 libxt6 libxinerama1 libz-dev lsb xterm telnet dos2unix iproute2 dos2unix && \
    apt-get clean

# User account
ENV USER=ubuntu

# Setup default user
RUN useradd --create-home -s /bin/bash -m $USER && echo "$USER:ubuntu" | chpasswd && adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/$USER
USER $USER

# Arm Compiler 6 download file
ENV AC6=DS500-BN-00026-r5p0-18rel0.tgz

# Install Arm Compiler 6
RUN wget https://developer.arm.com/-/media/Files/downloads/compiler/$AC6
RUN mkdir /home/$USER/tmp
RUN tar xvfz $AC6  -C /home/$USER/tmp
RUN /home/$USER/tmp/install_x86_64.sh --i-agree-to-the-contained-eula --no-interactive -d /home/$USER/AC6
RUN rm -rf /home/$USER/tmp
RUN rm $AC6
ENV PATH "/home/$USER/AC6/bin:$PATH"

# Download and install Corestone SSE-300 FVP MPS3
RUN wget -qO- https://developer.arm.com/-/media/Arm%20Developer%20Community/Downloads/OSS/FVP/Corstone-300/MPS3/FVP_Corstone_SSE-300_Ethos-U55_11.14_24.tgz | tar -xz
RUN ./FVP_Corstone_SSE-300_Ethos-U55.sh --no-interactive --i-agree-to-the-contained-eula -d /home/$USER/FVP_Corstone_SSE-300_Ethos-U55 
RUN rm ./FVP_Corstone_SSE-300_Ethos-U55.sh
ENV PATH "/home/$USER//FVP_Corstone_SSE-300_Ethos-U55/models/Linux64_GCC-6.4:$PATH"

# Install Cortex-R and Cortex-M bare metal GNU tools
RUN wget -qO-  https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 | tar xj
ENV PATH "/home/$USER/gcc-arm-none-eabi-10-2020-q4-major/bin:$PATH"

# CMSIS pack support
RUN wget https://github.com/ARM-software/CMSIS_5/releases/download/5.7.0/cbuild_install.0.10.0.sh
RUN chmod +x cbuild_install.0.10.0.sh
RUN ./cbuild_install.0.10.0.sh -x /home/$USER/cbuild
RUN rm cbuild_install.0.10.0.sh
RUN mv /home/$USER/cbuild/bin/cbuildgen.lin /home/$USER/cbuild/bin/cbuildgen
ADD --chown=$USER:$USER GCC.10.2.1.mak /home/$USER/cbuild/etc
ADD --chown=$USER:$USER ARMCC.6.15.0.mak /home/$USER/cbuild/etc
ENV CMSIS_PACK_ROOT "/home/$USER/packs"
ENV CMSIS_COMPILER_ROOT "/home/$USER/cbuild/etc"
ENV CMSIS_BUILD_ROOT "/home/$USER/cbuild/bin/"
ENV PATH "/home/$USER/cbuild/bin:$PATH"
RUN cp_init.sh

# Download and install CMSIS-PACK Validation tools
RUN wget https://github.com/ARM-software/CMSIS_5/raw/develop/CMSIS/Utilities/Linux64/PackChk
RUN mv PackChk /home/$USER/cbuild/bin/PackChk
RUN chmod +x /home/$USER/cbuild/bin/PackChk

# Install Packs: CMSIS, DFP for FVPs
ADD --chown=$USER:$USER packlist /home/$USER
RUN cp_install.sh packlist

# Modify the ARMLMD_LICENSE_FILE env var with your license server
ENV ARMLMD_LICENSE_FILE "7010@localhost"
ENV ARM_TOOL_VARIANT  "ult"

