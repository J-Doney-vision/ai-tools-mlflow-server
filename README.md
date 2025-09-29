# ai-tools-mlflow-server

Docker-based MLflow tracking server with PostgreSQL backend. Defaults to local file artifacts; optional MinIO for S3.

## Setup
1. Copy .env.example to .env and edit if needed.
2. Run `docker-compose up -d` for local mode.

Access MLflow UI at http://localhost:5000

## Local Mode (Default, No MinIO)
Artifacts saved to ./mlruns on host (or custom path like /mnt/hdd/mlflow - edit volumes in docker-compose.yml).

## MinIO Mode (Optional S3)
1. Edit .env with MinIO creds.
2. Run `./scripts/setup.sh` to create bucket.
3. Start: `docker-compose -f docker-compose.yml -f docker-compose.minio.yml up -d`

MinIO Console at http://localhost:9001 (login from .env).

## Network Access (Other PCs on WiFi)
- Host IP (e.g., 192.168.0.100 - check with `ip addr show`).
- MLflow: http://192.168.0.100:5000
- MinIO (if used): http://192.168.0.100:9001
- In logger: MLflowLogger("http://192.168.0.100:5000", "exp")

## Custom Artifact Path (Local Mode)
Edit docker-compose.yml volumes: - /mnt/hdd/mlflow:/mlruns
Ensure path exists: mkdir -p /mnt/hdd/mlflow

## Stop
docker-compose down  # Add -v to remove data

## Contributing
Fork, PR to main. Run linting with pre-commit.

## Changelog
See CHANGELOG.md