#  Network isolation in a namespace.

## [network-policy-default-deny](network-policy-default-deny.sh)

in this scenario, we will create two pods and one pod is assigned the network policy which deny all connections from other pods.

## [network-policy-with-pod-selector](network-policy-with-pod-selector.sh) 
In this scenario, we create a network policy which allows Only the pods with the app=webserver Label to connect to the pods with app=database label.

