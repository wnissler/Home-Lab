#!/bin/bash
sudo kubeadm init 

sudo mkdir $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config

kubeadm token create --print-join-command