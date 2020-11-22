docker build -t wazzadevli0/multi-client:latest -t wazzadevli0/multi-client:$SHA ./client/Dockerfile ./client
docker build -t wazzadevli0/multi-server:latest -t wazzadevli0/multi-server:$SHA ./server/Dockerfile ./server
docker build -t wazzadevli0/multi-worker:latest -t wazzadevli0/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push wazzadevli0/multi-client:latest
docker push wazzadevli0/multi-server:latest
docker push wazzadevli0/multi-worker:latest

docker push wazzadevli0/multi-client:$SHA
docker push wazzadevli0/multi-server:$SHA
docker push wazzadevli0/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wazzadevli0/multi-server:$SHA
kubectl set image deployments/client-deployment client=wazzadevli0/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wazzadevli0/multi-worker:$SHA