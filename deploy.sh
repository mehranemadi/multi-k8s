docker build -t mehranemadi/multi-client:latest -t mehranemadi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mehranemadi/multi-server:latest -t mehranemadi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mehranemadi/multi-worker:latest -t mehranemadi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mehranemadi/multi-client:latest
docker push mehranemadi/multi-server:latest
docker push mehranemadi/multi-worker:latest

docker push mehranemadi/multi-client:$SHA
docker push mehranemadi/multi-server:$SHA
docker push mehranemadi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=mehranemadi/multi-server:$SHA
kubectl set image deployments/client-deployments client=mehranemadi/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=mehranemadi/multi-worker:$SHA