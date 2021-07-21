# liferay
Supports Postgres 9.3
Step 1 : Run the postgres container 
docker run -p 5432:5432 --name postgresql_liferay -d postgres:9.3

Step2 :
# Then create database and user :

docker run -it --link postgresql_liferay:postgres --rm postgres:9.3 sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

postgres=# CREATE USER lportal WITH PASSWORD 'lportal';
postgres=# CREATE DATABASE lportal WITH ENCODING 'UTF8';
postgres=# GRANT ALL PRIVILEGES ON DATABASE lportal to lportal;
postgres=# \q

Step 3 : Run liferay server
docker run -it -p 8080:8080 --link postgresql_liferay:postgres -e DB_TYPE=POSTGRESQL liferayportal
