#!/bin/bash -x

if [[ -z "${ARTIFACT_URI}" ]]; then
    export ARTIFACT_URI="file:///mlflow/artifacts"
fi

if [[ -z "${DATABASE_URI}" ]]; then
    export DATABASE_URI="postgresql://mlflow:mlflow@localhost/mlflow"
fi

if [[ -z "${MLFLOW_PORT}" ]]; then
    export MLFLOW_PORT=8002
fi

exec mlflow server \
    --host=0.0.0.0 \
    --port=$MLFLOW_PORT \
    --backend-store-uri=$DATABASE_URI \
    --artifacts-destination=$ARTIFACT_URI \
    --serve-artifacts
