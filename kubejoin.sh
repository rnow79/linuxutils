#!/bin/bash
# Author: Arnau Carrasco <arnau.carrasco@gmail.com>
#
# This script has to be executed in k8s master node. It picks the first available token (if
# there is no token, creates one) and calculates the hash of the ca certificate. Then it
# constructs the kubeadm join command. You should update the kubernetes_cluster variable

kubernetes_cluster="10.43.0.32:6443"

token=`kubeadm token list | grep -v ^TOKEN | head -n 1 | expand | tr -s " " | cut -d " " -f1`
if [ "$token" == "" ] ; then
 echo "No token available, creating new one..."
 token=`kubeadm token create`
fi
hash=`openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | cut -d " " -f2`

echo TOKEN: $token
echo HASH: $hash
echo "JOIN COMMAND:"
echo "kubeadm join --token $token $kubernetes_cluster --discovery-token-ca-cert-hash sha256:$hash"
