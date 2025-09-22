#!/bin/bash
echo "🐳 Docker Management Script"

case "$1" in
    start)
        echo "Starting Docker services..."
        docker-compose up -d
        ;;
    stop)
        echo "Stopping Docker services..."
        docker-compose down
        ;;
    status)
        echo "Docker containers status:"
        docker ps -a
        ;;
    logs)
        docker-compose logs -f
        ;;
    *)
        echo "Usage: $0 {start|stop|status|logs}"
        exit 1
        ;;
esac
