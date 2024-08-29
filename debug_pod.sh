#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <deployment-name> <namespace>"
    exit 1
fi

DEPLOYMENT_NAME=$1
NAMESPACE=$2
DEBUG_POD_NAME="${DEPLOYMENT_NAME}-debug-pod"

echo "Deleting pod $DEBUG_POD_NAME (if it exists)"
kubectl delete pod $DEBUG_POD_NAME -n $NAMESPACE --ignore-not-found

kubectl run $DEBUG_POD_NAME \
    --image=alpine \
    --restart=Never \
    -n $NAMESPACE \
    --overrides="$(kubectl get deployment $DEPLOYMENT_NAME -n $NAMESPACE -o json | jq -r '
    {
      "apiVersion": "v1",
      "kind": "Pod",
      "metadata": {
        "name": "'$DEBUG_POD_NAME'",
        "namespace": "'$NAMESPACE'"
      },
      "spec": {
        "containers": [
          {
            "name": "debug-container",
            "image": "alpine",
            "command": ["env"],
            "envFrom": .spec.template.spec.containers[0].envFrom,
            "env": .spec.template.spec.containers[0].env
          }
        ],
        "restartPolicy": "Never"
      }
    }')"

if [ $? -ne 0 ]; then
    echo "Failed to create debug pod"
    exit 1
fi

while [[ $(kubectl get pod $DEBUG_POD_NAME -n $NAMESPACE -o jsonpath='{.status.phase}') != "Succeeded" && \
         $(kubectl get pod $DEBUG_POD_NAME -n $NAMESPACE -o jsonpath='{.status.phase}') != "Failed" ]]; do
    echo "Waiting for pod $DEBUG_POD_NAME to complete..."
    sleep 2
done

echo ""
kubectl logs $DEBUG_POD_NAME -n $NAMESPACE | sort
echo ""

echo "Deleting pod $DEBUG_POD_NAME (if it exists)"
kubectl delete pod $DEBUG_POD_NAME -n $NAMESPACE --ignore-not-found