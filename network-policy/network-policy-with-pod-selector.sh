# create pod
kubectl run webserver --image=nginx --restart=Never --labels=app=webserver

kubectl run database --image=nginx --restart=Never --labels=app=database

kubectl run other --image=nginx --restart=Never --labels=app=other

sleep 10

# get database pod ip
database_ip=$(kubectl get pod database -o jsonpath='{.status.podIP}')

# create network-policy
kubectl create -f network-policy-with-pod-selector.yaml

sleep 10

# try connect webserver from database
echo "try curl $database_ip from webserver"
kubectl exec -it webserver -- env database_ip=$database_ip bash -c 'echo curl ${database_ip} from webserver; curl ${database_ip}'

# try connect webserver from other
echo "try curl $database_ip from other"
kubectl exec -it other -- env database_ip=$database_ip bash -c 'echo curl ${database_ip} from other; curl ${database_ip}'

# delete resources
kubectl delete pod webserver
kubectl delete pod database
kubectl delete pod other
kubectl delete networkpolicy pod-selector


