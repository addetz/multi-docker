docker build -t classicaddetz/multi-client:latest -t classicaddetz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t classicaddetz/multi-server:latest -t classicaddetz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t classicaddetz/multi-worker:latest -t classicaddetz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push classicaddetz/multi-client:latest
docker push classicaddetz/multi-server:latest
docker push classicaddetz/multi-worker:latest

docker push classicaddetz/multi-client:$SHA
docker push classicaddetz/multi-server:$SHA
docker push classicaddetz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=classicaddetz/multi-server:$SHA
kubectl set image deployments/client-deployment client=classicaddetz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=classicaddetz/multi-worker:$SHA


