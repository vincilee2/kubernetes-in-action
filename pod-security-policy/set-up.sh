#!/bin/bash
# refer to https://minikube.sigs.k8s.io/docs/tutorials/using_psp/
minikube start --extra-config=apiserver.enable-admission-plugins=PodSecurityPolicy --addons=pod-security-policy
