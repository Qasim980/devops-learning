# 🐳 Docker & Containers: Part 2 (Beyond a Single Container)

⬅️ **[Back to Part 1: Fundamentals](README.md)**

Part 1 covered building and running one container. This part covers what comes next: connecting containers, running multi-container apps, sharing images through registries, making images smaller, and managing containers at scale.

---

## 📚 Contents

1. [Docker networking](#-docker-networking)
2. [Docker Compose](#-docker-compose)
3. [Docker registries (Docker Hub & AWS ECR)](#-docker-registries)
4. [Multi-stage builds](#-multi-stage-builds)
5. [Orchestration: Docker Swarm vs Kubernetes](#-orchestration-docker-swarm-vs-kubernetes)
6. [Command cheat sheet](#-command-cheat-sheet)
7. [Glossary](#-glossary)
8. [What's next](#-whats-next)

---

## 🌐 Docker networking

Networking is what lets containers talk to each other and to the outside world.

| Network type | What it does |
|--------------|--------------|
| **Bridge** (default) | Containers on the same machine can reach each other by IP |
| **Host** | The container uses the host's network directly, with no isolation |
| **None** | No network at all, for containers that shouldn't have network access |

### Linking containers with a custom network

On a **custom bridge network**, containers can reach each other **by name** instead of by IP. IPs can change when a container restarts. Names don't.

Example: an app that talks to a MySQL database.

```bash
# 1. Create the network
docker network create my-custom-network

# 2. Start MySQL on that network
docker run -d \
  --name mydb \
  --network my-custom-network \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  mysql:8
```

- `--name mydb`: other containers on the network can now reach it at the hostname `mydb`
- `--network`: attaches it to the custom network
- `-e`: sets an **environment variable** (here, the root password)
- `mysql:8`: the image name and version tag

> ⚠️ Hard-coding passwords is fine for learning. In real projects, secrets go in a `.env` file or a secrets manager, never in Git.

### Debugging

```bash
docker logs <container-name>
```

This shows a container's output. It's the first place to look when a container crashes or exits straight away (e.g. a missing package).

---

## 🧱 Docker Compose

Running several containers with long `docker run` commands gets messy fast. **Docker Compose** lets you describe the whole app (all containers, networks, ports and environment variables) in one `docker-compose.yml` file.

- Compose **automatically creates a network** for the containers, so they can reach each other by service name
- The setup is written down in a file, so everyone on the team runs it the same way

### Example: Flask + MySQL

```yaml
services:
  web:
    build: .
    ports:
      - "5002:5002"
    depends_on:
      - db

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw
```

```bash
docker compose up -d     # start everything in the background
docker compose down      # stop and remove everything
```

> 💡 Older guides use `docker-compose` (with a hyphen). That's Compose v1, which is now retired. The current command is `docker compose` (with a space).

---

## 🏪 Docker registries

A **registry** is where images are stored and shared, like GitHub but for images.

**Why registries matter:**
- ✅ **Simpler deployment**: servers pull the exact image they need
- ✅ **Better collaboration**: teammates use the same images
- ✅ **Consistency**: the same image runs in dev, test and production

### Docker Hub (public)

A public registry with a huge library of official and community images.

```bash
# Build and tag as username/image-name:version
docker build -t abulqasim98/flask-mysql:v1 .

# Push it to Docker Hub
docker push abulqasim98/flask-mysql:v1

# Pull it on any other machine
docker pull abulqasim98/flask-mysql:v1
```

### AWS ECR (private)

**Elastic Container Registry** is AWS's private registry, used for production workloads.

1. Create a repository in the ECR section of the AWS console
2. Log Docker in to ECR:
   ```bash
   aws ecr get-login-password --region <region> \
     | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
   ```
3. Use **"View push commands"** in the console to build, tag and push the image
4. Pull the image from ECR and run it with Docker Compose to manage a multi-container app

---

## 🪶 Multi-stage builds

A **multi-stage build** splits a Dockerfile into stages. One stage has all the build tools. The final stage copies in **only what's needed to run the app**.

Smaller images mean:
- faster pushes, pulls and deployments
- less stored on disk and in the registry
- fewer packages, so fewer security holes

```dockerfile
# Stage 1: build
FROM python:3.12 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# Stage 2: run (slim image, no build tools)
FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /install /usr/local
COPY . .
CMD ["python", "app.py"]
```

---

## 🎛️ Orchestration: Docker Swarm vs Kubernetes

Once you have lots of containers across many servers, you need an **orchestrator** to:
- manage large-scale deployments
- keep apps available (high availability)
- scale automatically and recover from failures
- make good use of server resources

| Docker Swarm | Kubernetes |
|--------------|------------|
| Good for smaller deployments | Industry standard for large-scale deployments |
| Built into Docker | Separate system, not limited to Docker |
| Scaling is mostly manual | Auto-scaling |
| Easy to set up a cluster | Harder to set up a cluster |

*(Kubernetes is a later module in my roadmap.)*

---

## 🧾 Command cheat sheet

| Command | What it does |
|---------|--------------|
| `docker network create <name>` | Create a custom network |
| `docker compose up -d` | Start all services in `docker-compose.yml` |
| `docker compose down` | Stop and remove them |
| `docker push <user>/<image>:<tag>` | Upload an image to a registry |
| `docker pull <user>/<image>:<tag>` | Download an image from a registry |
| `docker system prune` | Remove all unused containers, networks and images |

---

## 📖 Glossary

| Term | Meaning |
|------|---------|
| **Bridge network** | Docker's default network, letting containers on one machine talk to each other |
| **Environment variable** | A setting passed into a container at start-up (`-e`) |
| **Docker Compose** | A tool for defining and running multi-container apps from one YAML file |
| **Registry** | A storage and sharing hub for images (Docker Hub, ECR) |
| **Multi-stage build** | A Dockerfile with separate build and run stages, giving a smaller final image |
| **Orchestration** | Automatically managing many containers across many servers |

---

## 🔗 What's next

Docker is the foundation for the rest of my roadmap:
- **AWS**: running containers in the cloud (ECR → ECS)
- **CI/CD (GitHub Actions)**: building and pushing images automatically on every commit
- **Kubernetes**: orchestrating containers at scale
- **Final ECS project**: putting it all together in a real-world deployment
