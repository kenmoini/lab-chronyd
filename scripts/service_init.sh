#!/bin/bash

set -x

RUNTIME="podman"
#RUNTIME="crictl"

CONTAINER_NAME="lab-chronyd"
CONTAINER_VOLUME_ROOT="/opt/${CONTAINER_NAME}"
CONTAINER_IMAGE="docker.io/publicarray/chrony:latest"
CONTAINER_NETWORK_NAME="host"
CONTAINER_RESOURCE_LIMITS="-m 64m"
CONTAINER_PORTS="-p 123/udp -p 323/udp"
#CONTAINER_VOLUMES="-v ${CONTAINER_VOLUME_ROOT}/config/chrony.conf:/etc/chrony.conf:Z -v ${CONTAINER_VOLUME_ROOT}/volumes/chrony:/etc/chrony:Z"
CONTAINER_VOLUMES="-v ${CONTAINER_VOLUME_ROOT}/config/chrony.conf:/etc/chrony.conf:Z"

################################################################################### EXECUTION PREFLIGHT
## Ensure there is an action arguement
if [ -z "$1" ]; then
  echo "Need action arguement of 'start', 'restart', or 'stop'!"
  echo "${0} start|stop|restart"
  exit 1
fi

################################################################################### SERVICE ACTION SWITCH
case $1 in

  ################################################################################# RESTART/STOP SERVICE
  "restart" | "stop" | "start")
    echo "Stopping container services if running..."

    echo "Killing ${CONTAINER_NAME} container..."
    /usr/bin/podman kill ${CONTAINER_NAME}

    echo "Removing ${CONTAINER_NAME} container..."
    /usr/bin/podman rm -f -i ${CONTAINER_NAME}
    ;;

esac

case $1 in

  ################################################################################# RESTART/START SERVICE
  "restart" | "start")

    echo "Pulling container image..."
    podman pull ${CONTAINER_IMAGE}

    echo "Starting container services..."

    # Deploy container
    echo -e "Deploying ${CONTAINER_NAME}...\n"
    podman run -dt \
    --cap-add SYS_TIME \
    --network "${CONTAINER_NETWORK_NAME}" ${CONTAINER_PORTS} \
    --name ${CONTAINER_NAME} \
    ${CONTAINER_RESOURCE_LIMITS} \
    ${CONTAINER_VOLUMES} \
    ${CONTAINER_IMAGE}

    ;;

esac