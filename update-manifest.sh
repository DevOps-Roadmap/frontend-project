#!/bin/bash

set -x

mkdir -p /tmp/temp_repo
git clone https://github.com/ajuzajay/frontend-project.git /tmp/temp_repo

cd /tmp/temp_repo

sed -i "s|image:.*|image: ajayjohn100/frontend-project:$2:$3|g" k8s/simple/frontend-deployment.yaml

git add .
git commit -m "update manifest"
git push
