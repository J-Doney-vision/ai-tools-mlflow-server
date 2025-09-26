FROM ubuntu:20.04

# Install system depedencies
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y build-essential gcc supervisor gettext-base nginx apache2-utils wget
RUN rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_INSTALLER_NAME="miniconda_installer.sh"
ENV CONDA_INSTALL_DIR="/root/miniconda3"

RUN wget -q -O ${CONDA_INSTALLER_NAME} \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash ${CONDA_INSTALLER_NAME} -b -p ${CONDA_INSTALL_DIR} \
    && rm -f ${CONDA_INSTALLER_NAME}

ENV PATH="${CONDA_INSTALL_DIR}/bin:${PATH}"

# Install requirements
RUN conda install python pandas -y
RUN conda install psycopg2 boto3 mlflow=1.26.1 -c conda-forge -y

# Setup nginx and mlflow
RUN addgroup -gid 1000 www \
    && adduser -uid 1000 -H -D -s /bin/sh -G www www

COPY nginx.conf.template /app/nginx.conf.template

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entry-point.sh /app/entry-point.sh

COPY ./webserver.sh /app/webserver.sh
COPY ./mlflow.sh /app/mlflow.sh

CMD ["/bin/bash", "/app/entry-point.sh"]
