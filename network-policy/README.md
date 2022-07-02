#  Network isolation in a namespace.

## [network-policy-deny-other-namespaces](network-policy-deny-other-namespaces.sh)

in this scenario, we will create two pods and one pod is assigned the network policy which deny all traffics from other namespaces. Notice that we need create service for the target pod or it won't work.

## [network-policy-with-pod-selector](network-policy-with-pod-selector.sh) 
In this scenario, we create a network policy which allows Only the pods with the app=webserver Label to connect to the pods with app=database label.

# Tips
[Use network policy in MiniKube](https://simondrake.dev/2022-01-09-testing_network_policies_with_minikube/)