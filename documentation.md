# ai-tools-mlflow-server Documentation

This document provides a complete guide to setting up, running, and customizing the MLflow tracking server using Docker. The server is designed to run locally on your machine, with options for network accessibility (e.g., from other PCs on the same WiFi). It's built with PostgreSQL for metadata storage and MinIO for artifacts (S3-compatible). All services run in containers for isolation and reproducibility.

## Prerequisites
- Docker installed (version 20+ recommended).
- Docker Compose installed (included with Docker Desktop or separate via `pip install docker-compose`).
- Basic knowledge of environment variables and ports.
- For GPU/ONNX support (optional): Ensure host has CUDA drivers if using in logger.

## Installation
No Python installation needed—everything runs in Docker.

1. Clone the repo:
   ```
   git clone https://github.com/verihubs/ai-tools-mlflow-server.git
   cd ai-tools-mlflow-server
   ```

2. Copy the example env file:
   ```
   cp .env.example .env
   ```

## How to Run
The server runs locally by default. Use Docker Compose to start.

1. **Start the Server**:
   ```
   docker-compose up -d
   ```
   - `-d` runs in detached mode (background).
   - First run builds the MLflow image (takes a few minutes).

2. **Verify Services**:
   - MLflow UI: Open http://localhost:5000 in browser.
   - MinIO Console: http://localhost:9001 (login with MINIO_ROOT_USER/MINIO_ROOT_PASSWORD from .env, default minioadmin/minioadmin).
   - Check logs: `docker-compose logs -f`.

3. **Setup MinIO Bucket** (first time):
   ```
   ./scripts/setup.sh
   ```
   - Creates the 'mlflow' bucket for artifacts.

4. **Stop the Server**:
   ```
   docker-compose down
   ```
   - Add `-v` to remove volumes (data loss warning).

## What to Edit
Customize via `.env` (do not commit; .gitignore ignores .env).

- **Database Creds** (PostgreSQL):
  - POSTGRES_DB=mlflow_db
  - POSTGRES_USER=mlflow
  - POSTGRES_PASSWORD=mlflow  # Change for security.

- **MinIO Creds** (Artifacts):
  - MINIO_ROOT_USER=minioadmin
  - MINIO_ROOT_PASSWORD=minioadmin  # Change; used for S3 access.
  - MLFLOW_S3_BUCKET=mlflow  # Bucket name for artifacts.

- **Ports** (if conflicts):
  - Edit docker-compose.yml ports, e.g., "5001:5000" for MLflow on host port 5001.

- **MLflow Version**: Edit Dockerfile RUN pip install mlflow==<version> (e.g., 2.17.0).

- **Local Artifact Path**: Volumes mounted to ./mlflow on host – edit for custom path.

Re-run `docker-compose up -d` after edits.

## If You Only Want It to Be Local (No Network Access)
The setup is local by default (runs on your machine). To restrict to localhost only (no WiFi/PC access):

1. **Bind to localhost**: In docker-compose.yml, change mlflow command:
   ```
   command: mlflow server --host 127.0.0.1 --port 5000
   ```
   - For MinIO, add --address ":9000" --console-address ":9001" to command, but bind ports to "127.0.0.1:5000:5000".

2. **Firewall**: Block ports 5000, 9000, 9001 on host (e.g., ufw deny 5000 on Ubuntu).

3. **No External Deps**: No changes needed; all in Docker.

Access only from host: http://localhost:5000.

## Artifact Management
- **Logging Artifacts**: In logger, use MLflowLogger with tracking_uri=http://localhost:5000 (or host IP for network).
- **Path**: Artifacts in s3://mlflow/artifacts/... (MinIO bucket).
- **Local Access**: Browse MinIO console or mount ./mlflow folder on host to view files directly.
- **Backup**: Copy volumes (docker volume ls; docker cp).

## Troubleshooting
- **Port Conflicts**: Change ports in docker-compose.yml.
- **Data Persistence**: Volumes (db-data, minio-data) persist; remove with docker-compose down -v.
- **Logs**: docker-compose logs mlflow
- **Test Connection**: curl http://localhost:5000

For production, add auth (NGINX proxy) or use managed MLflow (e.g., Databricks).

See CHANGELOG.md for updates.