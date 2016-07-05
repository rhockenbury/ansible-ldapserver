#!/bin/bash

sudo apt-get -y update
sudo apt-get -y dist-upgrade
sudo apt-get -y install curl vim git git-core build-essential
sudo apt-get -y install libssl-dev libffi-dev libpq-dev python-dev python-pip

sudo apt-get -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible

sudo ansible-galaxy install -r /vagrant/requirements.yml -f
ansible-playbook -i "localhost," -c local /vagrant/playbook.yml
