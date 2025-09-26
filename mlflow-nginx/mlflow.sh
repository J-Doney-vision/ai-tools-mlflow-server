#!/bin/bash -x

if [[ -z "${ARTIFACT_URL}" ]]; then
    export ARTIFACT_URL="mlruns"
fi

if [[ -z "${DATABASE_URL}" ]]; then
    export DATABASE_URL="./mlruns"
fi

if [[ -z "${MLFLOW_PORT}" ]]; then
    export MLFLOW_PORT=8003
fi

exec mlflow server --port=$MLFLOW_PORT --backend-store-uri=$DATABASE_URL --default-artifact-root=$ARTIFACT_URL
