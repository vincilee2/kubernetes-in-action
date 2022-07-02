set -a
. "../common/utils.sh"

# create namespace
kubectl create namespace n1
kubectl create namespace n2
# create pod
kubectl run nginx1 --image=nginx --restart=Never --labels=app=v1 -n n1 --expose --port=80
kubectl run nginx2 --image=nginx --restart=Never --labels=app=v2 -n n2 --expose --port=80

waitForPodCreated nginx1 n1
waitForPodCreated nginx2 n2
# try connect ngix1 from ngix2
n1SvcHost=$(getSvcQueryHost nginx1 n1)

echo "try curl $n1SvcHost from nginx2"
kubectl exec -it nginx2 -n n2 -- env hostAddress=$n1SvcHost bash -c 'echo curl ${hostAddress} from nginx2; curl ${hostAddress}'

# create network-policy
kubectl create -f network-policy-deny-other-namespaces.yaml -n n1

# try connect ngix1 from ngix2 again
echo "try curl $n1SvcHost from nginx2 after creating deny network policy"
kubectl exec -it nginx2 -n n2 -- env hostAddress=$n1SvcHost bash -c 'echo curl ${hostAddress} from nginx2; curl ${hostAddress}'

# delete resources
kubectl delete namespace n1
kubectl delete namespace n2
