#!/usr/bin/env bash
set -e

# Remove a potentially pre-existing server.pid for Rails
if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

# If a DATABASE_URL or DB_HOST is provided, try to run migrations/setup, else skip
if [ -n "$DATABASE_URL" ] || [ -n "$DB_HOST" ]; then
  echo "Waiting for database to be ready..."
  # Try to run rails db:prepare until it succeeds or we hit the retry limit
  retries=0
  until bundle exec rails db:prepare >/dev/null 2>&1; do
    retries=$((retries+1))
    if [ $retries -ge 20 ]; then
      echo "Database still not ready after $retries attempts - continuing and letting Rails handle errors"
      break
    fi
    echo "DB not ready yet (attempt: $retries). Sleeping 2s..."
    sleep 2
  done
fi

exec "$@"
