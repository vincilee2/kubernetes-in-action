function waitForPodCreated
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