#!/bin/bash

# for Ubuntu 22.04 & ROS2 最新版， 注：可用 glados 先翻墙

# 1. Set locale

sudo apt update && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# 2. Add the ROS 2 apt repository

# sudo apt install software-properties-common -y
# sudo add-apt-repository universe



# 3. add the ROS 2 apt repository to your system. First authorize our GPG key with apt.


sudo apt update &&  sudo apt install curl gnupg lsb-release -y
# curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo cp ./ros.key /usr/share/keyrings/ros-archive-keyring.gpg


# 4. Then add the repository to your sources list.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 5. Install development tools and ROS tools

sudo apt update && sudo apt install -y \
  python3-testresources \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-pip \
  python3-rosdep2 \
  python3-vcstool \
  wget
# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8 \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools
# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
sudo apt install --no-install-recommends -y \
  libcunit1-dev

# 6. Get ROS 2 code

mkdir -p ~/ros2_humble/src
cp ./ros2.repos ~/ros2_humble
cd ~/ros2_humble
# wget https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos
 vcs import src < ros2.repos
# cp -r ./src/* ~/ros2_humble/src

# 7. Install dependencies using rosdep

sudo apt upgrade

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"

# 8. Build the code in the workspace

cd ~/ros2_humble/
colcon build --symlink-install

# 9. Environment setup

# Replace ".bash" with your shell if you're not using bash
# Possible values are: setup.bash, setup.sh, setup.zsh
. ~/ros2_humble/install/local_setup.bash