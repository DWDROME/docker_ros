#!/bin/bash
# run_foxy_dev.sh
docker start -ai foxy_dev || \
docker run -it --name foxy_dev \
    --net=host \
    --privileged \
    -v ~/x3_ws:/ros2_ws \
    ros2_foxy_dev
