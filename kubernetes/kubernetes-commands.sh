#!/bin/bash
#
####Annotating pods
kubectl annotate pod pod-name annnotation-key=annotaion-value #annotates a specified pod
#
####Namespacing
kubectl get ns #this lists available namespaces
kubectl get po --namespace namespace #get pods in a specified namespace
kubectl create namespace custom-namespace #creates a namespace
kubectl create -f kubia-manual.yaml -n custom-namespace #creates pod in specified namespace
#
####Deleting pods
kubectl delete pod kubia-gpu #deleting pods by name
kubectl delete pod -l creation_method=manual #deleting pods by label
kubectl delete ns custom-namespace #deleting a namespace and all its resources
kubectl delete pod --all #deleting all pods in the current namespace
kubectl delete all --all #deleting all resources in the current namespace
