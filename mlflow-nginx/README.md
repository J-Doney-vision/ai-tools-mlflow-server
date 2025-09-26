Adapted from [mlflow-easyauth](https://github.com/soundsensing/mlflow-easyauth)


# Deploying with Docker


Clone this git repo & build the image

```
docker build -t verihubs/mlflow:1.26.1-nginx .
```

Set env parameter (on docker create/run) or create a env-file (e.g. `settings.env`) to set up mlflow server.

For example, when using s3 (or s3-compatible) filestore and postgres backend store, set env or use env-file like below

```bash
MLFLOW_TRACKING_USERNAME=myusername  # change this accordingly
MLFLOW_TRACKING_PASSWORD=mypassword  # change this accordingly
DATABASE_URL=postgresql://mlflow:mlflow@localhost/mlflow  # database URI, for example postgresql
MLFLOW_S3_ENDPOINT_URL=http://localhost:9000  # defined to specify s3 endpoint, optional (only if you use s3)
AWS_ACCESS_KEY_ID=mlflow-local  # defined to specify s3 credential, optional (only if you use s3)
AWS_SECRET_ACCESS_KEY=mlflow-local  # defined to specify s3 credential, optional (only if you use s3)
ARTIFACT_URL=s3://mlflow  # artifact store URI
PORT=8002  # port for nginx basic auth
MLFLOW_PORT=8003  # port for mlflow
```


Run it, e.g.

```
docker run -it -p 8001:6000 --net=host --env-file=settings.env my-mlflow-easyauth:latest
```
