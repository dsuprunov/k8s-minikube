# k8s-minikube

## Something general

- minikube start --driver=docker
- minikube status
- minikube stop
- minikube delete

- kubectl delete service hello-node
- kubectl delete deployment hello-node

- minikube dashboard --url

## demo-portal

- `docker build -t dsuprunov/demo-portal:latest ./services/demo-portal --no-cache`
- `docker push dsuprunov/demo-portal:latest`
- `kubectl apply -k infra/demo-portal/overlays/dev/`
- `minikube service demo-portal-service --url`

## hello-node

https://kubernetes.io/docs/tutorials/hello-minikube/

- `kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -- /agnhost netexec --http-port=8080`
- `kubectl get deployments`
- `kubectl get pods`
- `kubectl get events`
- `kubectl logs hello-node-...`
- `kubectl expose deployment hello-node --type=LoadBalancer --port=8080`
- `kubectl get services`
- `minikube service hello-node`
- `kubectl delete service hello-node`
- `kubectl delete deployment hello-node`