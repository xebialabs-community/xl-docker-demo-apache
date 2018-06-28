#!/bin/bash

image_name="xebialabsunsupported/xl-docker-demo-apache"
./dockertags httpd alpine > /tmp/httpd
./dockertags $image_name alpine > /tmp/xl
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
while read tag ; do
    docker build -t $image_name:$tag --build-arg httpd_tag=$tag .
    docker push $image_name:$tag
done < <(comm -23 <(sort /tmp/httpd) <(sort /tmp/xl))