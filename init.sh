#!/bin/bash

set -e

EC2_HOST=$1
EC2_USER=$2
SSH_KEY_PATH=$3

if [ $# -lt 3 ]; then
    echo "Failed to initialize because there are missing variables"
    exit 1
fi

ssh -i "$SSH_KEY_PATH" "$EC2_USER@$EC2_HOST" << EOF
    sudo su << EOF
        echo "Installing Python and its dependencies"
        apt-get update
        apt-get upgrade
        apt install -y python3 python3-pip python3-venv
        apt install -y build-essential python3-dev
        apt install -y libssl-dev libffi-dev
        echo "Finished installing Python and its dependencies"
        echo "Initilizing main script"
        chmod +x ./init_inside_ssh.sh
        ./init_inside_ssh.sh
    EOF
EOF