# Usar uma imagem base com ROS2
FROM osrf/ros:humble-desktop

# Clonando os gits necessários
WORKDIR /home/arquivos
RUN git clone https://github.com/OpenKinect/libfreenect2.git
RUN git clone https://github.com/jsb19227/kinect_v2_ros2_wrapper.git

# Atualizar e instalar pacotes necessários
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-rosdep \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*
    
# Dependências do libfreenect2
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libusb-1.0-0-dev \
    libglfw3-dev \
    libturbojpeg-dev

# Instalando o libfreenect2
WORKDIR /home/arquivos/libfreenect2/build
RUN cmake ..
RUN make
RUN make install
# CMD ./bin/Protonect  # script de teste do libfreenect2

# Instalando a implementação de kinect para ros2
WORKDIR /home/arquivos/kinect_v2_ros2_wrapper
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    cmake -DCMAKE_INSTALL_PREFIX=/home/arquivos/kinect_v2_ros2_wrapper/ ."
RUN make
RUN make install
CMD ./kinect2_node