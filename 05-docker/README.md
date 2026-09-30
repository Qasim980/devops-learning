# 05 - Docker

Containers changed everything. Docker packages and runs applications consistently.

## What You'll Learn

- Container vs VM concepts
- Images and containers
- Dockerfile syntax
- Building images
- Docker Compose for multi-container apps
- Volumes and networking
- Best practices for production images

## Folder Structure

```
05-docker/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Containerise a web application
- [ ] Create a multi-container app with Docker Compose
- [ ] Build a minimal production image (multi-stage build)
- [ ] Set up a local development environment with Docker

## Key Commands

```bash
docker build -t name .      # Build image
docker run -d -p 80:80 img  # Run container
docker ps                   # List running containers
docker logs <container>     # View logs
docker exec -it <c> sh      # Shell into container
docker-compose up -d        # Start compose stack
docker-compose down         # Stop compose stack
```

## Dockerfile Best Practices

```dockerfile
# Use specific tags, not :latest
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Run as non-root user
USER node

# Define entrypoint
CMD ["node", "server.js"]
```

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
