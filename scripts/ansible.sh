#!/bin/bash
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
sudo apt install sshpass -y

ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
#TO-DO - pass this in without hardcoding
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@192.168.1.10
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@192.168.1.11
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@192.168.1.12

sudo cat ~/inventory.cfg | sudo tee /etc/ansible/hosts

ansible -m ping all