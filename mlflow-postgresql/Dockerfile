FROM ubuntu:20.04

# Install system depedencies
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y build-essential gcc supervisor gettext-base wget
RUN rm -rf /var/lib/apt/lists/*

# Install mambaforge
ENV CONDA_INSTALLER_NAME="mambaforge_installer.sh"
ENV CONDA_INSTALL_DIR="/root/mambaforge"

RUN wget -q -O ${CONDA_INSTALLER_NAME} \
    https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && bash ${CONDA_INSTALLER_NAME} -b -p ${CONDA_INSTALL_DIR} \
    && rm -f ${CONDA_INSTALLER_NAME}

ENV PATH="${CONDA_INSTALL_DIR}/bin:${PATH}"

# Install requirements
RUN mamba install python pandas psycopg2 mlflow==2.0.1 -y

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entry-point.sh /app/entry-point.sh
COPY ./mlflow.sh /app/mlflow.sh

CMD ["/bin/bash", "/app/entry-point.sh"]
