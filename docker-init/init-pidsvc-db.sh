#!/bin/bash
set -e

THIS_SCRIPT="${BASH_SOURCE[0]}"
PIDSVC_SCRIPTS_DIR=$( cd "$(dirname "${THIS_SCRIPT}")/pidsvc" && pwd)

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER "pidsvc-admin";
    ALTER USER "pidsvc-admin" WITH password 'pidsvc123';
    CREATE DATABASE pidsvc;
    GRANT ALL PRIVILEGES ON DATABASE pidsvc TO "pidsvc-admin";
EOSQL

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname pidsvc -f "${PIDSVC_SCRIPTS_DIR}/postgresql.sql"
