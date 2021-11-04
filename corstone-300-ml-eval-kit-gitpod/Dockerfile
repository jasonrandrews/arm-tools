FROM gitpod/workspace-full-vnc


RUN sudo apt-get update && \
      sudo apt-get -y install sudo git vim wget make curl zip xterm telnet bc build-essential libsndfile1 software-properties-common && \
      sudo rm -rf /var/lib/apt/lists/*
RUN sudo add-apt-repository ppa:deadsnakes/ppa -y
RUN sudo apt-get update
RUN sudo apt install python3.7 python3.7-dev python3.7-venv -y

# User account
ENV USER=gitpod

WORKDIR /home/$USER
USER $USER

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

# Install cmake 3.15.6 required to build the Ethos-U55 driver
RUN mkdir /home/$USER/cmake
RUN wget -N https://github.com/Kitware/CMake/releases/download/v3.15.6/cmake-3.15.6-Linux-x86_64.sh
RUN bash /home/$USER/cmake-3.15.6-Linux-x86_64.sh --skip-license --exclude-subdir --prefix=/home/$USER/cmake
RUN rm cmake-3.15.6-Linux-x86_64.sh
RUN sed -i "s|cortex-m3|cortex-m55|g" /home/$USER/cmake/share/cmake-3.15/Modules/CMakeDetermineCCompiler.cmake
RUN sed -i "s|cortex-m3|cortex-m55|g" /home/$USER/cmake/share/cmake-3.15/Modules/CMakeDetermineCXXCompiler.cmake
ENV PATH "/home/$USER/cmake/bin:$PATH"

#------------------------------------------------------------------
# Install Vela to optimize the NN model to run on Ethos-U55
#------------------------------------------------------------------
RUN python3.7 -m venv env
ENV PATH=/home/$USER/env/bin:${PATH}
RUN pip install --upgrade wheel pip setuptools
RUN pip install ethos-u-vela
RUN pip install Pillow

# Download and install Corestone SSE-300 FVP MPS3
RUN wget -qO- https://developer.arm.com/-/media/Arm%20Developer%20Community/Downloads/OSS/FVP/Corstone-300/FVP_Corstone_SSE-300_11.15_24.tgz | tar -xz
RUN ./FVP_Corstone_SSE-300.sh --no-interactive --i-agree-to-the-contained-eula -d /home/$USER/FVP_Corstone_SSE-300
RUN rm ./FVP_Corstone_SSE-300.sh
ENV PATH "/home/$USER//FVP_Corstone_SSE-300/models/Linux64_GCC-6.4:$PATH"

# Copy GDB Plugin for FVP
RUN mkdir /home/$USER/system
COPY --chown=$USER:$USER GDBRemoteConnection.so /home/$USER/system
COPY --chown=$USER:$USER GDBreadme.txt /home/$USER/system

# Modify the ARMLMD_LICENSE_FILE env var with your license server
ENV ARMLMD_LICENSE_FILE "7010@localhost"
ENV ARM_TOOL_VARIANT  "ult"
ENV GIT_SSL_NO_VERIFY 1
ENV PIP_USER "false"


