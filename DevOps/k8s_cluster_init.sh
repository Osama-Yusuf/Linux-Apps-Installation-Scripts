#!/bin/bash

echo """ 
# make sure you set hostname for both master and worker nodes
    sudo hostnamectl set-hostname master
    sudo hostnamectl set-hostname worker

# Do this step for every node
    # edit /etc/hosts file
        sudo vi /etc/hosts
        # add the following lines

        <master_node_private_ip> <master_node_hostname>
        <worker_node_private_ip> <worker_node_hostname>

        # refresh your terminal session for all nodes
            bash
"""

sleep 3

# enable kernal modules by adding the following the containerd configuration file 
cat << EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

# then enable the modules by running the following command
sudo modprobe overlay
sudo modprobe br_netfilter

# set up system level configuration related to network traffic forwarding
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# apply the configuration by running the following command
sudo sysctl --system

# install containerd
sudo apt update && sudo apt install -y containerd

# configure containerd
sudo mkdir -p /etc/containerd

# generate the default configuration file & save it to /etc/containerd/config.toml
sudo containerd config default | sudo tee /etc/containerd/config.toml

# restart containerd to make sure the changes take effect
sudo systemctl restart containerd

# kubernetes requires swap to be disabled
sudo swapoff -a

# install dependencies
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

# add the GPG key for the official Kubernetes repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# add the Kubernetes repository
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# update packages and install kubelet, kubeadm & kubectl
sudo apt-get update && sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00

# hold the version of kubelet, kubeadm & kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# this is to bypass the error: "kubeadm init: error execution phase preflight: [preflight] Some fatal errors occurred:
sudo -i
echo 1 > /proc/sys/net/ipv4/ip_forward
exit

# ------------------------------ for master node ----------------------------- #
    
k8s_master() {
    # initialize the cluster
    sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version v1.24.0

    # set up local kubeconfig for kubectl to be able to communicate with the cluster
    mkdir -p $HOME/.kube
    # copy the admin kubeconfig file to the local kubeconfig file path
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    # set the ownership of the local kubeconfig file to the current user to avoid the need to use sudo
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    # install flannel network plugin for pod networking (this is for master node only)
    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

    echo "make sure to add port 6443 to the security group of the master node (if using aws instance)"

    # copy the output of the following command to join the worker nodes
    kubeadm token create --print-join-command

    echo "copy the output of the above command and paste it on the worker nodes"
    echo "after joining the worker nodes, run the following command to check the status of the cluster"
    echo "kubectl get nodes"
}

check_master_node() {
    read -p "Is this the master node? (y/n) " check_master
    if [ "$check_master" = "y" ]; then
        clear
        k8s_master
    elif [ "$check_master" = "n" ]; then
        echo "Enter the master node and execute the script again to initialize the cluster"
    else
        clear
        echo "Invalid input, Please enter y or n"
        check_master_node
    fi
}
check_master_node

# ------------------------------ for worker node ----------------------------- #

# paste the output of the last master node command to join the worker nodes
# for ex: 
    # kubeadm join <master_private_ip>:6443 --token <token_id> --discovery-token-ca-cert-hash sha256:<token_hash>
