# create pod
kubectl run nginx1 --image=nginx --restart=Never --labels=app=v1
kubectl run nginx2 --image=nginx --restart=Never --labels=app=v2

sleep 10
# get nginx1 pod ip
ip1=$(kubectl get pod nginx1 -o jsonpath='{.status.podIP}')

# try connect ngix1 from ngix2
echo "try curl $ip1 from nginx2"
kubectl exec -it nginx2 -- env ip1=$ip1 bash -c 'echo curl ${ip1} from nginx2; curl ${ip1}'

# create network-policy
kubectl create -f network-policy-default-deny.yaml

sleep 10
# try connect ngix1 from ngix2 again
echo "try curl $ip1 from nginx2 after creating deny network policy"
kubectl exec -it nginx2 -- env ip1=$ip1 bash -c 'echo curl ${ip1} from nginx2 after creating deny netwoek plicy; curl ${ip1}'

# delete resources
kubectl delete pod nginx1
kubectl delete pod nginx2
kubectl delete networkpolicy default-deny 
