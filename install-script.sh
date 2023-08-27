#!/bin/bash

# Update package repository
sudo yum update -y

# Install Java
sudo yum install -y java*

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo yum install -y jenkins

# Start Jenkins
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Open firewall port 8080
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

# Retrieve initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Provide instructions to the user
echo "Jenkins installation is complete."
echo "Access the Jenkins web UI by navigating to http://your-server-ip:8080"
echo "Use the initial admin password provided above to complete the setup."

