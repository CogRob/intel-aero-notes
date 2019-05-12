export ROS_MASTER_URI=http://100.80.228.75:11311/
export ROS_IP=100.80.226.255
source /opt/ros/kinetic/setup.bash
roslaunch rtabmap_ros rgbd_mapping.launch rtabmap_args:="--delete_db_on_start" depth_registered_topic:=/camera/depth/image_rect_raw &
