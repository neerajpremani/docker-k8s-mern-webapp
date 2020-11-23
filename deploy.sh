docker build -t neerajpremani/multi-client:latest -t neerajpremani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neerajpremani/multi-server:latest -t neerajpremani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neerajpremani/multi-worker:latest -t neerajpremani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push neerajpremani/multi-client:latest
docker push neerajpremani/multi-server:latest
docker push neerajpremani/multi-worker:latest

docker push neerajpremani/multi-client:$SHA
docker push neerajpremani/multi-server:$SHA
docker push neerajpremani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=neerajpremani/multi-server:$SHA
kubectl set image deployments/client-deployment client=neerajpremani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=neerajpremani/multi-worker:$SHA