#!/bin/bash

set -e

EC2_HOST=$1
EC2_USER=$2

if [ $# -lt 2 ]; then
    echo "Failed to initialize because there are missing variables"
    exit 1
fi

ssh "$EC2_USER@$EC2_HOST" << EOF
    sudo su << EOF
        echo "Updating system"
        apt-get update -y
        apt-get upgrade -y
        echo "Finished update"
        DIR="braspag-automation-kafka"
        echo "Checking if main directory exists"
        if [ -d "$DIR" ]; then
            echo "Directory '$DIR' exists"
            cd braspag-automation-kafka
        else
            echo "Directory '$DIR' does not exist"
            git clone https://github.com/FelipeFranke5/braspag-automation-kafka.git
            cd braspag-automation-kafka
        fi
        echo "Initilizing main script"
        chmod +x ./init_inside_ssh.sh
        ./init_inside_ssh.sh
    << EOF
<< EOF