#!/bin/bash -x


if [[ -z "${PORT}" ]]; then
    export PORT=8002
fi

if [[ -z "${MLFLOW_PORT}" ]]; then
    export MLFLOW_PORT=8003
fi

envsubst '${PORT} ${MLFLOW_PORT}' < /app/nginx.conf.template > /etc/nginx/nginx.conf

htpasswd -b -c /etc/nginx/.htpasswd ${MLFLOW_TRACKING_USERNAME} ${MLFLOW_TRACKING_PASSWORD}

exec nginx -g "daemon off;"
