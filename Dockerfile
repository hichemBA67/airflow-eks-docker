FROM apache/airflow:1.10.11-python3.7

# Install dependencies and add Yarn's GPG key
RUN apt-get update \
    && apt-get install -y curl gnupg \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && sed -i '/dl.bintray.com\/sbt\/debian/d' /etc/apt/sources.list \
    && apt-get update

RUN pip install --user pytest

# Copy your Airflow configurations and DAGs into the container
COPY dags/ ${AIRFLOW_HOME}/dags
COPY unittests.cfg ${AIRFLOW_HOME}/unittests.cfg
COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
COPY unittests/ ${AIRFLOW_HOME}/unittests
COPY integrationtests ${AIRFLOW_HOME}/integrationtests
