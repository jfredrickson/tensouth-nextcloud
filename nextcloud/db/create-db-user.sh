#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $NC_dbuser;
    ALTER USER $NC_dbuser WITH ENCRYPTED PASSWORD '$NC_dbpassword';
    CREATE DATABASE $NC_dbname;
    GRANT ALL PRIVILEGES ON DATABASE $NC_dbname TO $NC_dbuser;
EOSQL
