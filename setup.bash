#!/bin/bash
sudo apt update && \
sudo apt install -y \
  curl \
  gnupg2 \
  lsb-release \
  && \
curl http://repo.ros2.org/repos.key | sudo apt-key add - && \
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' && \
sudo apt update && \
sudo apt install -y \
  build-essential \
  make \
  cmake \
  git \
  python3-pip \
  wget \
  && \
python3 -m pip install -U \
  rosdep \
  catkin-pkg \
  colcon-common-extensions \
  lark-parser \
  lxml \
  numpy \
  vcstool \
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
  setuptools \
  && \
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev \
  && \
mkdir src && \
wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos && \
bash -c 'export PATH=$PATH:~/.local/bin; \
  vcs import src < ros2.repos; \
  sudo rosdep init; \
  rosdep update; \
  rosdep install \
    --from-paths src \
	--ignore-src \
  	--rosdistro dashing -y \
  	--skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 rti-connext-dds-5.3.1 urdfdom_headers"' && \
sudo apt install -y libopensplice69 && \
sudo apt install -q -y rti-connext-dds-5.3.1 && \
cd /opt/rti.com/rti_connext_dds-5.3.1/resource/scripts && \
source ./rtisetenv_x64Linux3gcc5.4.0.bash; cd - && \
bash -c 'export PATH=$PATH:~/.local/bin; colcon build --symlink-install --merge-install' && \
echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
