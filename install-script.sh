#!/bin/bash

# Update package repository and install necessary tools
yum update -y
yum install -y java-1.8.0-openjdk-devel git

# Install Maven
yum install -y wget
wget https://apache.osuosl.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
tar -xzvf apache-maven-3.8.4-bin.tar.gz -C /opt
ln -s /opt/apache-maven-3.8.4 /opt/maven
echo 'export M2_HOME=/opt/maven' >> /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
systemctl start jenkins
systemctl enable jenkins

# Install Docker
amazon-linux-extras install -y docker
systemctl start docker
systemctl enable docker

# Install Ansible
amazon-linux-extras install -y ansible

# Install kubectl for Kubernetes
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install Grafana
yum install -y https://dl.grafana.com/oss/release/grafana-8.2.0-1.x86_64.rpm
systemctl start grafana-server
systemctl enable grafana-server

# You'll need to manually configure Kubernetes and Docker registry settings

# Finally, reboot to ensure all changes take effect
reboot
