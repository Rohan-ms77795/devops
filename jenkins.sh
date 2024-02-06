#!/bin/bash

# Update package repositories
sudo apt update -y

# Install dependencies
sudo apt install -y wget curl

# Install Temurin JDK
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/trusted.gpg.d/adoptium.asc > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list > /dev/null
sudo apt update -y
sudo apt install -y temurin-17-jdk

# Set up environment variables for Java
export JAVA_HOME=/usr/lib/jvm/temurin-17
export PATH=$PATH:$JAVA_HOME/bin

# Add Java environment variables to .bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/temurin-17' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# Reload .bashrc
source ~/.bashrc

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor --output /usr/share/keyrings/jenkins-archive-keyring.gpg

# Add Jenkins repository
echo 'deb [signed-by=/usr/share/keyrings/jenkins-archive-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package repositories
sudo apt update -y

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Check Jenkins service status
sudo systemctl status jenkins
