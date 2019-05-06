export ROS_MASTER_URI=http://192.168.8.1:11311/
export ROS_IP=192.168.8.106
source /opt/ros/kinetic/setup.bash
roslaunch rtabmap_ros rgbd_mapping.launch rtabmap_args:="--delete_db_on_start" depth_registered_topic:=/camera/depth/image_rect_raw &
