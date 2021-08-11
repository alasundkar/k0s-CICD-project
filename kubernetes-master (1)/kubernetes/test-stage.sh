#!/bin/bash

TOTAL_REVISION=`kubectl rollout history deploy springbootapp -n devops-tools | wc -l`
s=`kubectl get pods -n devops-tools | grep springbootapp | awk '{print($5)}'`

if [ $s = *s ] ; then
    VER=$((TOTAL_REVISION-2))
else
    VER=$((TOTAL_REVISION-1))
fi

VER=${VER}p
REVISION=`kubectl rollout history deploy springbootapp -n devops-tools | sed -n $VER | cut -d ' ' -f1`
echo "REVISION Number Before Deployment: ${REVISION}"
TEST_CODE=`curl -I http://${1}:{$2}/ | sed -n '1p' | cut -d " " -f2`

if [ ${TEST_CODE} -eq 200 ]
then
    echo "Application Tested Successfully. No Need To Deploy Revision: ${REVISION}"
else
    echo $REVISION "Will Deploy this Revision"
fi