#!/bin/bash

# Update package repository
yum update -y

yum install -y python3-pip
yum install unzip -y

# Function to install a package if not already installed
install_package() {
    package_name=$1
    if ! yum list installed "$package_name" >/dev/null 2>&1; then
        echo "$package_name not found. Installing $package_name..."
        yum install -y "$package_name"
    else
        echo "$package_name is already installed."
    fi
}

# Install Java 17
install_package java-17-openjdk-devel

# Install necessary tools
install_package git
install_package wget

# Install Maven if not already installed
if ! command -v mvn; then
    install_package java-1.8.0-openjdk-devel # Ensure Java 8 for Maven
    echo "Installing Maven..."
    wget https://apache.osuosl.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
    tar -xzvf apache-maven-3.8.4-bin.tar.gz -C /opt
    ln -s /opt/apache-maven-3.8.4 /opt/maven
    echo 'export M2_HOME=/opt/maven' >> /etc/profile.d/maven.sh
    echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
    chmod +x /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
    # Run `mvn install` here
    mvn install
else
    echo "Maven is already installed."
fi

# ... (Rest of the script)

# Finally, inform the user about reboot
echo "All installations completed. You may consider rebooting to ensure all changes take effect."
