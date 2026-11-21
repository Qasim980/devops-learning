# 🐳 Docker & Containers: Part 1 (Fundamentals)

My notes and key takeaways from the **Docker module** of the [CoderCo](https://coderco.io) DevOps bootcamp.

This part covers what containers are, how they compare to virtual machines, and how to build and run your own images.

➡️ **[Part 2: Networking, Compose, Registries & Orchestration](ADVANCED.md)**

---

## 📚 Contents

1. [What is a container?](#-what-is-a-container)
2. [Docker's main parts](#-dockers-main-parts)
3. [Images vs containers](#-images-vs-containers)
4. [Containers vs virtual machines](#-containers-vs-virtual-machines)
5. [Writing a Dockerfile](#-writing-a-dockerfile)
6. [The Docker workflow](#-the-docker-workflow)
7. [Command cheat sheet](#-command-cheat-sheet)
8. [Glossary](#-glossary)

---

## 📦 What is a container?

A **container** is a small, portable package that holds an application **and everything it needs to run**: the code, the runtime, the libraries and other dependencies.

Because everything travels together, and the container is **isolated** from the rest of the system, the app runs the same way on a laptop, a test server or the cloud. This fixes the classic "it works on my machine" problem.

---

## 🧩 Docker's main parts

Docker is an open platform for building, shipping and running containers.

| Component | What it does |
|-----------|--------------|
| **Docker Engine** | The runtime that builds and runs containers on a machine |
| **Docker Hub** | A cloud service for storing and sharing images |
| **Docker Compose** | A tool for defining and running several containers together |

---

## 🖼️ Images vs containers

| Term | What it is | Analogy |
|------|-----------|---------|
| **Dockerfile** | The list of steps used to build an image | The recipe |
| **Image** | A read-only template (a snapshot of the app at a point in time) | The cake mould |
| **Container** | A running instance of an image | The actual cake |

You can start many containers from one image.

---

## ⚖️ Containers vs virtual machines

Both let you run apps in isolated environments. They do it in different ways. *(This comes up a lot in interviews.)*

| Virtual Machines | Containers |
|------------------|------------|
| Slow to start | Start in seconds |
| Use more resources | Resource efficient |
| Strong isolation | Process-level isolation |
| Less portable (large, carry a full OS) | Highly portable |
| Run on a **hypervisor** | Run on the **Docker Engine** |
| Each VM has its own guest OS | All containers share the host OS kernel |

**When to use which:**
- **Containers** are lightweight and quick, so they suit modern cloud-native apps.
- **VMs** suit apps that need full isolation, or when you need to run a different OS on the same host (e.g. Windows on a Linux server).

---

## 📝 Writing a Dockerfile

A Dockerfile is a text file with the steps for building an image. The main instructions:

| Instruction | Purpose |
|-------------|---------|
| `FROM` | The base image to start from |
| `WORKDIR` | Sets the working folder for the next instructions |
| `COPY` | Copies files from your machine into the image |
| `RUN` | Runs a command while the image is being built (e.g. install packages) |
| `CMD` | The command that runs when the container starts |

### Example: a simple Flask app

```dockerfile
# Start from an official, slim Python image
FROM python:3.12-slim

# Do everything from inside /app in the image
WORKDIR /app

# Copy the dependency list first, then install (this layer is cached)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

# Start the app when the container runs
CMD ["python", "app.py"]
```

Build it:

```bash
docker build -t hello-flask .
```

- `-t hello-flask` gives the image a name (a **tag**)
- `.` is the **build context**: it sends the files in the current folder to Docker so the `COPY` steps can use them

---

## 🔄 The Docker workflow

```
Dockerfile  ──docker build──▶  Image  ──docker run──▶  Container
```

1. **Write** a Dockerfile
2. **Build** an image from it
3. **Run** the image as a container

```bash
docker run -d -p 5002:5002 hello-flask
```

- `-d` runs the container in **detached** mode (in the background)
- `-p 5002:5002` maps ports as `HOST_PORT:CONTAINER_PORT`, so visiting `localhost:5002` reaches the app inside the container

Stop it again:

```bash
docker ps                      # find the container ID
docker stop <container-id>
```

---

## 🧾 Command cheat sheet

### Containers
| Command | What it does |
|---------|--------------|
| `docker run <image>` | Create and start a container from an image |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers, including stopped ones |
| `docker stop <container>` | Stop a running container |
| `docker rm <container>` | Remove a stopped container |
| `docker logs <container>` | Show a container's output (debugging) |

### Images
| Command | What it does |
|---------|--------------|
| `docker build -t <name> .` | Build an image from a Dockerfile |
| `docker images` | List images on the machine |
| `docker inspect <id>` | Show full details (config, env variables, etc.) |
| `docker rmi <image>` | Remove an image |

---

## 📖 Glossary

| Term | Meaning |
|------|---------|
| **Container** | An isolated, running package of an app plus its dependencies |
| **Image** | A read-only template that containers are created from |
| **Dockerfile** | A text file with the steps to build an image |
| **Tag** | A label on an image, usually a version (e.g. `:v1`) |
| **Build context** | The folder of files sent to Docker during a build (the `.`) |
| **Detached mode** | Running a container in the background (`-d`) |
| **Port mapping** | Linking a host port to a container port (`-p`) |
| **Hypervisor** | Software that creates and runs virtual machines |

---

➡️ **Continue to [Part 2: Networking, Compose, Registries & Orchestration](ADVANCED.md)**
