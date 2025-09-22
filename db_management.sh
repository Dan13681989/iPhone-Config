#!/bin/bash
DB_CONTAINER="docker-configs-db-1"
backup_db() {
    docker exec $DB_CONTAINER pg_dump -U user myapp > ~/secure/backups/db_$(date +%Y%m%d_%H%M%S).sql
    echo "✅ Database backed up"
}
restore_db() {
    docker exec -i $DB_CONTAINER psql -U user myapp < $1
    echo "✅ Database restored from $1"
}
case "$1" in
    backup) backup_db ;;
    restore) restore_db $2 ;;
    *) echo "Usage: $0 {backup|restore file.sql}" ;;
esac
