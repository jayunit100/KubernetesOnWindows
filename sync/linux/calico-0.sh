#!/bin/sh
echo "running calico installer now...."
sleep 2
export KUBECONFIG=/home/vagrant/.kube/config
KUBECONFIG=/home/vagrant/.kube/config

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml #--kubeconfig=/home/vagrant/.kube/config
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml 
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "waiting 20s for calico pods..."
sleep 20
kubectl patch installation default --type=merge -p '{"spec": {"calicoNetwork": {"bgp": "Disabled"}}}'
kubectl get pods -n kube-system
