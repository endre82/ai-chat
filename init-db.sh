#!/bin/bash
set -e

echo "Waiting for PostgreSQL to be ready..."
MAX_ATTEMPTS=20
ATTEMPT=0
until pg_isready -p "5432" -U "$POSTGRES_USER"; do
  if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
    echo "PostgreSQL did not become ready in time."
    exit 1
  fi
  echo "Waiting for database to be ready... (Attempt $((ATTEMPT + 1)))"
  sleep 5
  ATTEMPT=$((ATTEMPT + 1))
done

# Check if the database already exists
DB_EXISTS=$(psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT 1 FROM pg_database WHERE datname='$NEW_DB'")
if [ "$DB_EXISTS" == "1" ]; then
  echo "Database $NEW_DB already exists, skipping creation."
else
  echo "Creating database $NEW_DB..."
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE DATABASE $OPENWEBUI_DB;
  CREATE USER $OPENWEBUI_USER WITH PASSWORD '$OPENWEBUI_PASSWORD';
  GRANT ALL PRIVILEGES ON DATABASE $OPENWEBUI_DB TO $OPENWEBUI_USER;

    -- Set new user as the owner of the database
    ALTER DATABASE $OPENWEBUI_DB OWNER TO $OPENWEBUI_USER;

    -- Grant privileges on the public schema
    \c $OPENWEBUI_DB
    ALTER SCHEMA public OWNER TO $OPENWEBUI_USER;
    GRANT ALL ON SCHEMA public TO $OPENWEBUI_USER;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $OPENWEBUI_USER;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $OPENWEBUI_USER;
    GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO $OPENWEBUI_USER;
EOSQL

  echo "Database and user setup completed."
fi
