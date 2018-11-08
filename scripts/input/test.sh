#!/usr/bin/env bash

set -e
addPatch=$(cat add-label-patch.json)
deletePatch=$(cat delete-label-patch.json)

echo "creating denier..."
kubectl apply -f denier.yaml

echo "Adding label secure=true to the deployment"
kubectl patch deployments helloworld --patch "$addPatch" --type json
echo "sleep 3m"
sleep 3m

echo "making curl to helloworld service in a loop... expecitng 403 response"
for i in {1..15}
do
	status=$(curl -s -o /dev/null -w "%{http_code}\n" http://helloworld:5000/hello)

	if [ $i -eq 15 ]; then
		if [ "$status" != "403" ]; then
			echo "received $status but expected 403"
			exit 1
		fi
	fi
	sleep 1s
done


echo "removing label secure=true from deployment"
kubectl patch deployments helloworld --patch "$deletePatch" --type json
echo "sleep 3m"
sleep 3m
echo "making curl to helloworld service in a loop... expecting 200 response"
for i in {1..15}
do
	status=$(curl -s -o /dev/null -w "%{http_code}\n" http://helloworld:5000/hello)
	
	if [ $i -eq 15 ]; then
		if [ "$status" != "200" ]; then
			echo "received $status but expected 200"
			exit 1
		fi
	fi
	sleep 1s
done

echo "deleting denier"
kubectl delete -f denier.yaml

exit $?