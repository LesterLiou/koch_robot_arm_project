FROM ubuntu:22.04 

ENV DEBIAN_FRONTEND=noninteractive

ENV ROS_DISTRO=humble \
    SHELL=/bin/bash \
    NB_USER=hrc \
    NB_UID=1000

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime


###################################### user #####################################
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} 

RUN echo "root:root" | chpasswd \
    && echo "${NB_USER}:111111" | chpasswd

ENV HOME=/home/${NB_USER}

###################################### basic #####################################
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
    ccache \
    g++ \
    gcc \
    gdb \
    gawk \
    make \
    ninja-build \
    python3-numpy \
    python3-dev \
    python3-pyparsing \
    python3-serial \
    python-is-python3 \
    libpython3-stdlib \
    libtool-bin \
    zip \
    default-jre \
    socat \
    tzdata \
    pip \
    dirmngr \
    gnupg2 \
    git \
    gitk git-gui \
    vim \
    less \
    curl \
    wget \
    sudo \
    cmake \
    swig \
    net-tools \
    lsb-release \
    gnupg \
    build-essential \
    libcgal-dev \
    libfftw3-dev \
    rapidjson-dev \
    pkg-config \
    libboost-system-dev \
    libopencv-dev \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-libav \
    gstreamer1.0-gl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

###################################### python pkg###############################
RUN apt-get update && apt-get upgrade pip -y && \
    pip install --upgrade pip && \
    pip install \
    numpy \
    scipy \
    matplotlib \
    scikit-learn \
    scikit-image \
    pandas \
    opencv-python \
    opencv-python-headless \
    pyyaml \
    pyquaternion \
    pymavlink \
    MAVProxy \
    pyserial \
    pexpect \
    Pillow \
    tensorboard \
    tensorflow \
    future

###################################### ros2 ####################################
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-desktop \
    ros-${ROS_DISTRO}-ros2-control \
    ros-${ROS_DISTRO}-ros2-controllers \
    ros-${ROS_DISTRO}-joy* \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-rosbridge-server \
    ros-${ROS_DISTRO}-vision-msgs \
    ros-${ROS_DISTRO}-ament-cmake \
    ros-${ROS_DISTRO}-geometry-msgs \
    ros-${ROS_DISTRO}-std-msgs \
    ros-${ROS_DISTRO}-sensor-msgs \
    ros-${ROS_DISTRO}-tf2-msgs \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-rviz-rendering \
    ros-${ROS_DISTRO}-rcl-interfaces \
    ros-${ROS_DISTRO}-urdf \
    ros-${ROS_DISTRO}-geographic-msgs \
    ros-${ROS_DISTRO}-topic-tools \
    ros-dev-tools \
    ros-${ROS_DISTRO}-launch-pytest \
    python3-colcon-common-extensions \
    python3-rosdep \
    ros-dev-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

###################################### lerobots ##############################
# Clone the repository
RUN git clone https://github.com/hrc-pme/lerobot.git /lerobot

# Set the working directory
WORKDIR /lerobot

# Upgrade pip and install lerobot with specified extras
RUN pip install --upgrade --no-cache-dir pip
RUN pip install --no-cache-dir --ignore-installed  ".[dynamixel]"

###################################### Install librealsense2 #####################################
# # Set the version of the RealSense library
# Warning: For build realsense2, it need more than 32G RAM please check with $htop while build the docker image, if the RAM occupy more than 90% of your total ram, please ctrl+C to stop build process. 
ENV LIBREALSENSE_VERSION=2.55.1

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev \
    libusb-1.0-0-dev \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    at \
    libudev-dev && \
    rm -rf /var/lib/apt/lists/*

# Clone and build librealsense from source
WORKDIR /home/${NB_USER}/repos
RUN git clone https://github.com/IntelRealSense/librealsense.git && \
    cd librealsense && \
    git checkout v${LIBREALSENSE_VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j$($(nproc)-2) install && \
    ldconfig
    
##################################### Apriltag ###############################
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ament-cmake-clang-format \
    ros-humble-apriltag-msgs \
    ros-humble-apriltag && \
    rm -rf /var/lib/apt/lists/*

################################### Image transport ##########################
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-image-transport \
    ros-humble-image-transport-plugins 


WORKDIR /home/${NB_USER}/repos
RUN rm -rf librealsense


################## setup auth & set env param into .bashrc#####################
RUN echo "root ALL=(ALL)  ALL" >> /etc/sudoers \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ${HOME}/.bashrc 

ENV XLA_PYTHON_CLIENT_PREALLOCATE=false

# # Support of nvidia-docker 2.0
# ENV NVIDIA_VISIBLE_DEVICES=all
# ENV NVIDIA_DRIVER_CAPABILITIES=all