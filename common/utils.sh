waitForPodCreated ()
{
    pod=$1
    namespace=$2
    Status=""
    while [ "Running" != "$Status" ]
    do
        Status=$(kubectl get pod $pod -n $namespace -o jsonpath='{.status.phase}')
        echo "$pod $Status"
        sleep 1
    done
}

getPodIp()
{
    pod=$1
    namespace=$2
    ip=$(kubectl get pod $pod -n $namespace -o jsonpath='{.status.podIP}')
    echo $ip
}

getSvcQueryHost()
{
    svcName=$1
    namespace=$2
    echo "$svcName.$namespace.svc.cluster.local"
}