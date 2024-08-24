#!/usr/bin/bash

docker build -t dsuprunov/demo-portal:latest ./services/demo-portal --no-cache

docker push dsuprunov/demo-portal:latest