#!/usr/bin/env bash
# Ensure environment.sh is sourced in ~/.bashrc
grep -qxF 'source ~/koch_robot_arm/environment.sh' ~/.bashrc || echo 'source ~/koch_robot_arm/environment.sh' >> ~/.bashrc

# Source environment.sh with an argument if provided
if [ -n "$1" ]; then
  source ~/koch_robot_arm/environment.sh "$1"
else
  source ~/koch_robot_arm/environment.sh
fi
