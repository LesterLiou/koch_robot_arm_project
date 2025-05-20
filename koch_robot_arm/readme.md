
# **Koch Robot Arm**  
This repository contains the code and environment setup for controlling the Koch robot arm using Hugging Face.  

---

## **Environment Setup**  

We provide Docker configurations for both **CPU** and **GPU** devices:  
- **CPU**: Use for Intel NUC or devices without a GPU  
- **GPU**: Use for devices with a GPU  

---

### **1. Start the Docker Environment**  

#### **CPU Version:**  
```bash
cd ~/koch_robot_arm
source cpu_run.sh
```

#### **GPU Version:**  
```bash
cd ~/koch_robot_arm
source gpu_run.sh
```

---

### **2. Build the ROS 2 Workspace**  
Build the workspace if this is your first time or after making any changes:  
```bash
cd ~/koch_robot_arm/ros2_ws
colcon build
# colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
```

---

### **3. Load Environment Parameters**  

For every new terminal:  
```bash
source ~/koch_robot_arm/environment.sh 
```

Or permanently set parameters:  
```bash
source ~/koch_robot_arm/set_env_param.sh 
```

### **4. Run the Apriltag**
```bash
ros2 launch apriltag_ros v4l2_36h11.launch.yml
```

---

### **⚠️ Important Notes**  
- Ensure **`colcon build`** is run from `~/koch_robot_arm/ros2_ws`.  
- Verify the environment is loaded by typing:  
  ```bash
  ros2 run koch_  # Then press Tab twice
  ```
  Then press `Tab` twice  
  You should see options like **koch_ros2_wrapper** and **koch_simulation** appear.

---

## **Repository Structure Overview**  

```plaintext
.
├── Docker                  # Docker setup files for CPU or GPU builds  
│   ├── cpu                # Dockerfile, build, and run scripts for CPU-based setup  
│   └── gpu                # Dockerfile, build, and run scripts for GPU-based setup  
├── ros2_ws                # ROS 2 workspace  
│   └── src                # Source code for ROS 2 packages  
│       ├── koch_ros2_wrapper   # ROS 2 wrapper integrating the Koch API and ROS 2 functions / koch related launch file (include camera)  
│       ├── koch_simulation     # URDF files and RViz robot models for testing  
│       └── topic_tools         # Tools for topic relay, throttle, and mux  
├── XXX_run.sh              # Symbolic link to Docker run script  
├── environment.sh          # Script to set ROS 2 environment variables (use in Docker)  
└── set_env_param.sh        # Script to copy environment variables to ~/.bashrc (use in Docker)  
```
### More Information on ROS 2 Packages  
For detailed information about each ROS 2 package, refer to their respective README files:  

1. **[koch_ros2_wrapper](https://github.com/hrc-pme/koch_ros2_wrapper)** – A ROS 2 wrapper integrating the Koch API with ROS 2 functions / koch related launch file (include camera) 
2. **[koch_simulation](https://github.com/hrc-pme/koch_robot_arm/tree/main/ros2_ws/src/koch_simulation)** – Contains URDF files and RViz robot models for testing and simulation.  
3. **[topic_tools](https://github.com/hrc-pme/topic_tools)** – Provides tools for topic relay, throttle, and mux.  

4. **[apriltag_ros](https://github.com/hrc-pme/apriltag_ros)** - ROS2 node for AprilTag detection
5. **[realsense_ros](https://github.com/hrc-pme/realsense-ros/tree/ros2-legacy)** - ROS2 node for Realsense2-camera (using tag 4.55.1 version)
---