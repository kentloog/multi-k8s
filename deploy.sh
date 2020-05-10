docker build -t kentloog/multi-client:latest -t kentloog/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kentloog/multi-server:latest -t kentloog/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kentloog/multi-worker:latest -t kentloog/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kentloog/multi-client:latest
docker push kentloog/multi-server:latest
docker push kentloog/multi-worker:latest

docker push kentloog/multi-client:$SHA
docker push kentloog/multi-server:$SHA
docker push kentloog/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kentloog/multi-server:$SHA
kubectl set image deployments/client-deployment client=kentloog/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kentloog/multi-worker:$SHA