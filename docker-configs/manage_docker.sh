#!/bin/bash
echo "🐳 Docker Management Script"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    echo "💡 Run: open -a Docker"
    exit 1
fi

case "$1" in
    start)
        echo "Starting Docker services..."
        docker compose up -d
        ;;
    stop)
        echo "Stopping Docker services..."
        docker compose down
        ;;
    status)
        echo "Docker containers status:"
        docker ps -a
        ;;
    logs)
        docker compose logs -f
        ;;
    test)
        echo "Testing web server..."
        curl http://localhost:8080
        ;;
    *)
        echo "Usage: $0 {start|stop|status|logs|test}"
        exit 1
        ;;
esac
