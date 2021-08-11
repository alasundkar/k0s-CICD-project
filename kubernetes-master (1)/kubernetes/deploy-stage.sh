#!/bin/bash
APP_EXISTS=`kubectl get deploy -n devops-tools | grep springbootapp | wc -l`

if [ ${APP_EXISTS} -eq 1 ];
then
    TOTAL_REVISION=`kubectl rollout history deploy springbootapp -n devops-tools | wc -l`
    VER=$((TOTAL_REVISION-1))
    VER=${VER}p
    REVISION=`kubectl rollout history deploy springbootapp -n devops-tools | sed -n $VER | cut -d ' ' -f1`
    echo "REVISION Number Before Deployment: ${REVISION}"
else
    echo "No Old Deployment Present"
fi

echo "--------------------------------------------------"
echo "Get All Resources In K8s"
kubectl get all -n devops-tools
echo "--------------------------------------------------"
echo "Deploy App"
kubectl apply -f http://{1}:{2}/rupesh/kubernetes/raw/branch/{3}/spring-boot-app.yml
kubectl apply -f http://{1}:{2}/rupesh/kubernetes/raw/branch/{3}/spring-boot-app-svc.yml
sleep 10
echo "--------------------------------------------------"
echo "Get All Resources In K8s After Deployment"
kubectl get all -n devops-tools
echo "--------------------------------------------------"