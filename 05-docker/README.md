# 🐳 Docker Module

Part of my **[CoderCo](https://coderco.io) DevOps bootcamp** journey.

This module covers containers and Docker: building and running images, connecting containers, running multi-container apps with Docker Compose, storing images in registries (Docker Hub and AWS ECR) and the basics of orchestration.

---

## 📁 What's in this folder

```
docker/
├── README.md          ← you are here
├── notes/
│   ├── README.md      ← Part 1: Fundamentals
│   └── ADVANCED.md    ← Part 2: Beyond a single container
└── challenge/         ← hands-on module challenge
```

---

## 📝 [notes/](notes/)

My write-up of everything I learned in this module, split into two parts.

### [Part 1: Fundamentals](notes/README.md)
- What containers are and the problem they solve
- Docker's main parts (Engine, Hub, Compose)
- Images vs containers
- Containers vs virtual machines
- Writing a Dockerfile
- The build → run workflow
- Command cheat sheet and glossary

### [Part 2: Beyond a single container](notes/ADVANCED.md)
- Docker networking (bridge, host, none, custom networks)
- Running multi-container apps with Docker Compose
- Pushing and pulling images with Docker Hub and AWS ECR
- Shrinking images with multi-stage builds
- Orchestration: Docker Swarm vs Kubernetes
- Command cheat sheet and glossary

---

## 🛠️ [challenge/](challenge/)

### Multi-container app: Flask + Redis

A Python Flask web app that counts page visits. The count is stored in Redis, and each service runs in its own container, managed by Docker Compose. **[Full write-up →](challenge/README.md)**

```
Browser ──► web (Flask) :5003 ──► redis :6379
            └──── Compose network ────┘
```

**What I used:**
- Two Dockerfiles: one for the Flask app, one for Redis
- Docker Compose to define, build and connect both services
- Compose's built-in DNS, so Flask reaches Redis by its service name, `redis`
- A `.dockerignore` file to keep unneeded files out of the image

**Key design decisions:**
- Only the Flask app is published to the host. Redis stays on the internal network because it has no password by default.
- The Redis `INCR` command keeps the counter correct even with several Flask instances.
- Flask binds to `0.0.0.0` so it accepts traffic from outside its container.
- Dependencies are installed before the code is copied in, so editing `app.py` doesn't reinstall every package.

**Highlights from debugging:**
- A container started with plain `docker run` couldn't resolve `redis`, because it sits on the default network instead of the Compose network.
- Port 5000 was taken by macOS AirPlay Receiver. I found it with `lsof` and moved the app to 5003.
- An old pre-built image was serving stale code. I switched to `build:` and checked the code with `docker compose exec`.

**How to run it:**

```bash
cd challenge
docker compose up --build
```

Then open `http://localhost:5003/` for the welcome message, or `http://localhost:5003/count` to increase the visit count.

---

## 🧠 Key skills from this module

- Packaging an application and its dependencies into a portable image
- Writing clean, efficient Dockerfiles
- Running and debugging containers (`docker logs`, `docker inspect`)
- Connecting containers over custom networks
- Defining multi-container apps as code with Docker Compose
- Publishing images to public (Docker Hub) and private (AWS ECR) registries
- Troubleshooting real problems: port conflicts, container DNS, stale images

---

## 🔗 Where this leads

Docker is the foundation for the next modules in my roadmap: **AWS** (ECR and ECS), **Terraform**, **CI/CD with GitHub Actions** (building and pushing images automatically), **Kubernetes**, and the final **ECS project** that brings them all together.
