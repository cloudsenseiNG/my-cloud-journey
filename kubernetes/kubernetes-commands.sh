#!/bin/bash
#
#Usage
#Copy any of the commands with no comment that serve your purpose 
#
####Creating Resources
kubectl create -f resource-file.yaml
#
####Annotating pods
kubectl annotate pod pod-name annnotation-key=annotaion-value #annotates a specified pod
#
####Namespacing
kubectl get ns #this lists available namespaces
kubectl get pod --namespace namespace-name #get pods in a specified namespace
kubectl create namespace namespace-name #creates a namespace
kubectl create -f file-name.yaml -n namespace #creates pod in specified namespace
#
####Deleting pods
kubectl delete pod pod-name #deleting pods by name
kubectl delete pod -l key=value #deleting pods by label
kubectl delete ns namespace #deleting a namespace and all its resources
kubectl delete pod --all #deleting all pods in the current namespace
kubectl delete all --all #deleting all resources in the current namespace
