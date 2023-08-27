#!/bin/bash

# Update package repository
yum update -y

# Install Java 17 if not already installed
if ! command -v java || ! java -version 2>&1 | grep "17.0.8" >/dev/null; then
    echo "Java 17 not found. Installing Java 17..."
    yum install -y java-17-openjdk-devel
else
    echo "Java 17 is already installed."
fi

# Install necessary tools
yum install -y git

# Install Maven if not already installed
if ! command -v mvn; then
    echo "Maven not found. Installing Maven..."
    yum install -y wget
    wget https://apache.osuosl.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
    tar -xzvf apache-maven-3.8.4-bin.tar.gz -C /opt
    ln -s /opt/apache-maven-3.8.4 /opt/maven
    echo 'export M2_HOME=/opt/maven' >> /etc/profile.d/maven.sh
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
    chmod +x /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
else
    echo "Maven is already installed."
fi

# Install Jenkins if not already installed
if ! command -v jenkins; then
    echo "Jenkins not found. Installing Jenkins..."
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    yum install -y jenkins
    systemctl start jenkins
    systemctl enable jenkins
else
    echo "Jenkins is already installed."
fi

# Install Docker if not already installed
if ! command -v docker; then
    echo "Docker not found. Installing Docker..."
    amazon-linux-extras install -y docker
    systemctl start docker
    systemctl enable docker
else
    echo "Docker is already installed."
fi

# Install Ansible if not already installed
if ! command -v ansible; then
    echo "Ansible not found. Installing Ansible..."
    amazon-linux-extras install -y ansible
else
    echo "Ansible is already installed."
fi

# Install kubectl if not already installed
if ! command -v kubectl; then
    echo "kubectl not found. Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/
else
    echo "kubectl is already installed."
fi

# Install Grafana if not already installed
if ! command -v grafana-server; then
    echo "Grafana not found. Installing Grafana..."
    yum install -y https://dl.grafana.com/oss/release/grafana-8.2.0-1.x86_64.rpm
    systemctl start grafana-server
    systemctl enable grafana-server
else
    echo "Grafana is already installed."
fi

# You'll need to manually configure Kubernetes and Docker registry settings

# Inform user about the manual configuration steps
echo "Please configure Kubernetes and Docker registry settings manually."

# Finally, inform user about reboot
echo "All installations completed. You may consider rebooting to ensure all changes take effect."
