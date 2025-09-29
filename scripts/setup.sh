#!/bin/bash

# Create MinIO bucket
docker exec -it minio mc mb local/mlflow

echo "Setup complete. Run docker-compose up -d"