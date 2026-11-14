#!/bin/bash

# Install and start NGINX on an Ubuntu EC2 instance (Ubuntu Server 24.04, eu-west-2)
# Note: Amazon Linux would use yum/dnf instead of apt

sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable --now nginx

# Verify
systemctl status nginx
curl -I localhost