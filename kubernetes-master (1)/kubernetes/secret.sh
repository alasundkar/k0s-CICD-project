#!/bin/bash
#Author: Rupesh Alasundkar
#Email: rupeshalasundkar@gmail.com
#######################################
# This Script Will Create Secret To Access Nexus-Docker-Repository
# How To Run This Script:
#  ./secret <secret password>
#######################################
kubectl create secret docker-registry nexus-spring-boot-key --docker-server=192.168.50.10:30700 --docker-username=admin --docker-password=${1} --namespace=devops-tools