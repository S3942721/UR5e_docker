# Use an official ROS2 image as a parent image
FROM ros:humble

# Set the working directory in the container to /home
WORKDIR /home

# Copy the current directory contents into the container at /home
COPY . /home

#RUN apt-get update && apt-get upgrade -y

# Install any needed packages
RUN apt-get update && apt-get install -y \
    ros-humble-moveit \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y pip # Pip
RUN apt-get update && apt-get install -y ros-humble-ur-robot-driver # Universal Robotics Drivers
RUN apt-get update -y && apt-get install -y iputils-ping # Ping
RUN apt-get update -y && apt-get install -y rviz # Rviz

# Clone UR5e Dev Repo
RUN git clone https://github.com/S3942721/on_UR5e.git

# Set environment variables to source setup.bash
ENV ROS_DISTRO=humble
ENV ROS_SETUP=/opt/ros/humble/setup.bash

# Source Humble
RUN echo "source \$ROS_SETUP" >> /etc/bash.bashrc

#RUN "source /opt/ros/humble/setup.bash

# Make port 502 available to the world outside this container
EXPOSE 502

# Define environment variable
#ENV NAME World

CMD ["/bin/bash"]
