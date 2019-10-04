Official documentation: https://github.com/intel-aero/meta-intel-aero/wiki/01-About-Intel-Aero

1. Use modified version of Intel Yocto that supports NVME driver. Your current drone has 32 GB of SD card. We added 512 GB NVME drive but default version of Yocto does not support that.

The instructions to rebuild Yocto are here:
https://github.com/CogRob/intel-aero-notes/blob/master/yocto_compile/README.md

I have a USB stick with the pre-compiled Yocto image that I can share.
Here's a link to the pre-compiled Yocto image: https://drive.google.com/open?id=1VfUl1K4xRaH_m07j1e436C9RrOokdtDM

2. Yocto Image has docker installed and we run ROS on top of Ubuntu on top of Docker. You should learn about docker and install docker.
https://docs.docker.com/get-started/

CogRob has it's own docker registry and we have intel-aero-drone related images there.
The Dockerfiles for the docker images are kept in the docker_registory repository. These are compiled nightly on a lab server.
https://github.com/CogRob/docker_registry

The images of our interest are:
1. https://github.com/CogRob/docker_registry/tree/master/ros_kinetic_aero_base/docker_image
2. https://github.com/CogRob/docker_registry/tree/master/ros_cogrob_aero_utils/docker_image

You can access the compiled docker images like this:

docker login docker.cogrob.com
Username: cogrob_shared_account
Password: uX6qm8rKneCzLEP7
docker pull docker.cogrob.com/ros_kinetic_aero_base
docker pull docker.cogrob.com/ros_cogrob_aero_utils


2.5 I will also give you one Intel T265. You can find another one from Qaijun. You should find a way to mount the Intel T265

3. Starting here, we are in uncharted territory. Feel free to improve steps from here and beyond. There are a few things that are not full automated (TODO: Try to automate them. The best thing is to have a single script that can be run after installing yocto that takes care of all of this.) Follow the steps here:

https://github.com/CogRob/internal_docs/blob/master/drones.md
UCSD Protected username password:
Username: cogrob
Password: AtkHall6

4. We have some scripts to control the robot in MAVROS setpoint mode. You are welcome to improve those scripts.

https://github.com/CogRob/quad_control

4.1 We use the external vision mode for PX4. Play around with QGroundControl parameters to see which one works the best.

Guide
https://github.com/PX4/Devguide/blob/master/en/ros/external_position_estimation.md

The set of parameters that we have found to work on other drones are:
https://github.com/CogRob/intel-aero-notes/tree/master/orion

5. Please improve https://github.com/CogRob/intel-aero-notes/blob/master/README.md with these instructions and any instructions you find to be missing.

6. TODO: Check out this repository: https://github.com/szebedy/autonomous-drone.
One of the features we would like to have is the ability to avoid obstacles using trajectory re-planner. It would be great if you could create a Docker image that takes care of that.

7. TODO: Test the geometric controllers in px4+gazebo simulation and then we can test them on real drones once they work on px4+gazebo.

Thanks for moving so fast and let me know if you have any questions :)
