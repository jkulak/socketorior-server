#!/usr/bin/env bash

docker push jkulak/socketorior

ssh -oStrictHostKeyChecking=no deploy@$DEPLOY_HOST << EOF

    docker pull jkulak/socketorior:latest
    docker stop socketorior || true
    docker rm socketorior || true
    docker rmi jkulak/socketorior:current || true
    docker tag jkulak/socketorior:latest jkulak/socketorior:current
    docker run -d --restart always --name socketorior -p 20207:8080 jkulak/socketorior:current
EOF
