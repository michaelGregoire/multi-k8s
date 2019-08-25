docker build -t mgregoire/multi-client:latest -t mgregoire/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mgregoire/multi-server:latest -t mgregoire/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mgregoire/multi-worker:latest -t mgregoire/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mgregoire/multi-client:latest
docker push mgregoire/multi-server:latest
docker push mgregoire/multi-worker:latest
docker push mgregoire/multi-client:$SHA
docker push mgregoire/multi-server:$SHA
docker push mgregoire/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mgregoire/multi-server:$SHA
kubectl set image deployments/client-deployment client=mgregoire/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mgregoire/multi-worker:$SHA
