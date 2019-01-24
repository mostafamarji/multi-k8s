docker build -t mostafamarji/multi-client:latest -t mostafamarji/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mostafamarji/multi-server:latest -t mostafamarji/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mostafamarji/multi-worker:latest -t mostafamarji/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mostafamarji/multi-client:latest
docker push mostafamarji/multi-server:latest
docker push mostafamarji/multi-worker:latest

docker push mostafamarji/multi-client:$SHA
docker push mostafamarji/multi-server:$SHA
docker push mostafamarji/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mostafamarji/multi-server:$SHA
kubectl set image deployments/client-deployment client=mostafamarji/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mostafamarji/multi-worker:$SHA

