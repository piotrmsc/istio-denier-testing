# istio-denier-testing
Testing scripts for istio deniers to reproduce issues in the Kyma


# Test scenario

1. Create an istio denier
2. Label the deployment "secure=true"
3. Make a curl to app expecting 403 returned based on created denier
4. Delete the "secure=true" label form the app
5. Make a curl to the app and expect 200 status code
6. Delete the denier

# How to run it

1. kubectl apply -f ./deployment.yaml
2. kubectl apply -f ./tester.yaml
