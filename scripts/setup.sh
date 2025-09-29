#!/bin/bash

# For MinIO mode only: Create bucket
docker exec -it minio mc mb local/mlflow

echo "MinIO setup complete. Run docker-compose -f docker-compose.yml -f docker-compose.minio.yml up -d"