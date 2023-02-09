#!/bin/bash
#
#Usage
#Copy any of the commands with no comment that serve your purpose 
#
####Creating Resources
kubectl create -f resource-file.yaml
#
####
kubectl describe resource resource-name #describe a specified resource-name
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
#
####Logging pods
kubectl logs mypod #provides log for the current pod
kubectl logs mypod --previous #provides log for the previous pod
#
####replication controllers
kubectl label pod pod-name key=value --overwrite 
kubectl delete rc rc-name --cascade=false #Keeps pods created by rc running regardless of deletion
kubectl scale rc rc-name --replicas=count #count is a number. scale pods horizontally
kubectl label pod pod-name key=value #label pod

####services
kubectl expose pod-name #creates a service for pod-name and assigns label based on pod's label selector
