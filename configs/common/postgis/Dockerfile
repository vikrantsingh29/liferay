FROM postgres:latest

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get install postgresql

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get install postgresql-12-postgis-3 -y \
    && apt-get install postgis -y

COPY ./sql-scripts /docker-entrypoint-initdb.d/

