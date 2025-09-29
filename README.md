# ai-tools-mlflow-server

Docker setup for MLflow tracking server with PostgreSQL. Defaults to local file artifacts; optional MinIO for S3.

## Setup
cp .env.example .env

## Default Mode (Local Artifacts)
1. Run `docker-compose up -d`
2. Access MLflow UI: http://localhost:5000
- Artifacts saved to ./mlruns on host (easy local access/view).

## MinIO Mode (S3 Artifacts)
1. Edit .env with MinIO creds.
2. Run `./scripts/setup.sh` (creates bucket).
3. Start with MinIO: `docker-compose -f docker-compose.yml -f docker-compose.minio.yml up -d`
- MinIO Console: http://localhost:9001 (login with MINIO_ROOT_USER/PASSWORD).
- Artifacts in s3://mlflow/... (view in MinIO or UI).

## Custom Artifact Path
By default, artifacts are saved to ./mlruns on host. To use a custom path (e.g., /mnt/hdd/mlflow):
1. Edit volumes in docker-compose.yml: - /mnt/hdd/mlflow:/mlruns
2. Ensure path exists on host: mkdir -p /mnt/hdd/mlflow
3. Run docker-compose up -d
- Artifacts now in /mnt/hdd/mlflow (access directly on host or via UI downloads).
- For backups, copy the folder.

If using MinIO mode (optional), artifacts are in S3 bucket—MinIO volumes can mount to custom path similarly (e.g., - /mnt/hdd/minio:/data).

## Network Access (Other PCs on WiFi)
- On host: Find IP (e.g., ip addr show -> 192.168.0.100).
- MLflow: http://192.168.0.100:5000
- MinIO (if used): http://192.168.0.100:9001
- In logger: MLflowLogger("http://192.168.0.100:5000", "exp")

## Stop
docker-compose down  # Or with -f for MinIO mode

## Contributing
See CONTRIBUTING.md

## Changelog
See CHANGELOG.md