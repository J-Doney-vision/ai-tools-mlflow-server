# ai-tools-mlflow-server

Docker setup for MLflow tracking server with PostgreSQL and MinIO.

## Setup
1. Copy .env.example to .env and edit if needed (e.g., passwords).
2. Run `docker-compose up -d`
3. Run `./scripts/setup.sh` to create MinIO bucket.

## Accessibility from Other PCs
- On host PC: Find IP with `ip addr show` (e.g., 192.168.0.100).
- MLflow UI: http://192.168.0.100:5000
- MinIO Console: http://192.168.0.100:9001 (login: minioadmin/minioadmin)
- From other PCs: Use host IP in logger tracking_uri (e.g., MLflowLogger("http://192.168.0.100:5000", "exp")).

## Artifact Storage
- Artifacts saved to MinIO bucket 'mlflow' (S3 path: s3://mlflow/artifacts/...).
- View/download from MLflow UI or MinIO console.
- Local hybrid: Mounted ./mlflow folder for direct file access on host.

## Customization
- Edit .env for creds/IP.
- For production: Use NGINX reverse proxy for security.

## Contributing
See CONTRIBUTING.md

## Changelog
See CHANGELOG.md