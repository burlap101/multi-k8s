docker build -t burlap101/multi-client:latest -t burlap101/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t burlap101/multi-server:latest -t burlap101/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t burlap101/multi-worker:latest -t burlap101/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push burlap101/multi-client:latest
docker push burlap101/multi-client:$SHA
docker push burlap101/multi-server:latest
docker push burlap101/multi-server:$SHA
docker push burlap101/multi-worker:latest
docker push burlap101/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=burlap101/multi-server:$SHA
kubectl set image deployments/client-deployment client=burlap101/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=burlap101/multi-worker:$SHA
