#!/bin/bash
#
#args1: 更新的项目 
#args2: 更新镜像的tag
#args3: docker-compose文件的路径位置

#docker-compose文件的路径
DOCKER_COMPOSE_FILE=$3

#step1: aws ecr 登录
eval $(aws ecr get-login --no-include-email)

#step2: 更新镜像tag
tags=`cat $DOCKER_COMPOSE_FILE | grep image| grep $1 | awk -F - '{print $NF}'`
sed -i "s#$1-$tags#$1-$2#g" $DOCKER_COMPOSE_FILE


#step3: 启动
docker-compose -f $DOCKER_COMPOSE_FILE up -d
