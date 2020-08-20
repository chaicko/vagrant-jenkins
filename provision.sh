#!/bin/bash

VAGRANT_HOST_DIR=/mnt/host_machine

########################
# Setup
########################
sudo service unattended-upgrades stop

########################
# Jenkins & Java
########################
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FCEF32E745F2C3D5 > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
echo "Installing Jenkins default user and config"
sudo cp $VAGRANT_HOST_DIR/JenkinsConfig/config.xml /var/lib/jenkins/
sudo mkdir -p /var/lib/jenkins/users/admin
sudo cp $VAGRANT_HOST_DIR/JenkinsConfig/users/admin/config.xml /var/lib/jenkins/users/admin/
sudo chown -R jenkins:jenkins /var/lib/jenkins/users/

# Java defaults to open ports on IPv6 and we cannot access it
# so we set it to IPv4
sudo sed -i 's/JAVA_ARGS="-Djava.awt.headless=true/& -Djava.net.preferIPv4Stack=true/' /etc/default/jenkins

# Start the Jenkins server
# sudo systemctl start jenkins

# Enable the service to load during boot
sudo systemctl enable jenkins
sudo systemctl status jenkins

########################
# Docker
########################
sudo usermod -aG docker "${USER}"
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

########################
# nginx
########################
echo "Installing nginx"
sudo apt-get -y install nginx > /dev/null 2>&1
sudo service nginx start

########################
# Configuring nginx
########################
echo "Configuring nginx"
cd /etc/nginx/sites-available
sudo rm default ../sites-enabled/default
sudo cp /mnt/host_machine/VirtualHost/jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/

########################
# Teardown
########################
sudo service docker restart
sudo service nginx restart
sudo service jenkins restart
sudo service unattended-upgrades restart
echo "Success"
