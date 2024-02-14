FROM ubuntu:22.04 
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_AU.UTF-8
ENV LANGUAGE=en_AU:en
ENV LC_ALL=en_AU.UTF-8
RUN apt-get update && apt-get -y upgrade
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_AU.UTF-8
RUN update-locale LC_ALL=en_AU.UTF-8 LANG=en_AU.UTF-8 
RUN apt-get update && apt-get install nano
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get update && add-apt-repository universe 
RUN apt-get update && apt-get install -y curl
RUN apt-get update && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN apt-get update && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt-get update && apt-get -y upgrade
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y ros-humble-desktop
#CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && exec \"$@\"", "--"]
RUN apt-get update && apt-get install -y python3-rosdep
RUN apt-get update && apt-get install -y git
RUN apt-get update && rosdep init && rosdep update
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get update && apt-get install -y python3-colcon-common-extensions
RUN apt-get update && apt-get install -y python3-colcon-mixin
RUN apt-get update && colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
RUN colcon mixin update default
RUN apt-get update && apt-get install -y python3-vcstool
ENV WS_HOME=/root
RUN mkdir -p $WS_HOME/ws_moveit2/src
WORKDIR $WS_HOME/ws_moveit2/src
RUN git clone --branch humble https://github.com/ros-planning/moveit2_tutorials
RUN vcs import < moveit2_tutorials/moveit2_tutorials.repos
RUN apt-get update && rosdep install -y -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y
WORKDIR $WS_HOME/ws_moveit2
#RUN colcon build --mixin release
CMD ["/bin/bash"]
