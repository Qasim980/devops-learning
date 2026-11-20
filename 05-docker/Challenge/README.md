# 🐳 Multi-Container Challenge: Flask + Redis

# A Multi-container app project

A Python Flask web app uses Redis to count page visits, with each service in its own container, managed by Docker Compose.

## Architecture

```
        Browser 🌐
           │
  http://localhost:5003
           │
┌──────────┼──────── Compose network ─────────┐
│          ▼                                  │
│   ┌──────────────┐   redis:6379   ┌───────┐ │
│   │  web (Flask) │ ─────────────► │ redis │ │
│   └──────────────┘                └───────┘ │
└─────────────────────────────────────────────┘
```

- **web**: the Flask app, and the only service published to the host
- **redis**: stores the `visits` counter; reachable only over the internal network

Flask connects using the hostname `redis`. Compose's built-in DNS resolves each **service name** to that container's IP address.

## 📁 Project structure

```
.
├── app.py               # Flask app: / and /count routes
├── requirements.txt     # flask, redis
├── Dockerfile           # Flask image
├── redis/Dockerfile     # Redis image
├── docker-compose.yml   # Defines and connects both services
└── .dockerignore
```

## 🚀 How to run

```bash
docker compose up --build   # build and start
docker compose ps           # check both services are up
docker compose down         # stop and remove
```

## 🔗 Endpoints

| URL | What it does |
|---|---|
| `http://localhost:5003/` | 👋 Welcome message |
| `http://localhost:5003/count` | 🔢 Increments and shows the visit count |

## 🧠 Key design decisions

- **`INCR` for the counter**: atomic, so the count stays correct across multiple Flask instances
- **Flask binds to `0.0.0.0`**: the default `127.0.0.1` would only accept traffic from inside the container
- **Dependencies installed before the code is copied**: layer caching means editing `app.py` doesn't reinstall packages
- **Redis not published to the host**: it has no password by default, and Flask reaches it internally anyway
- **`build:` instead of `image:`**: Compose rebuilds from source, so code changes get picked up

## 🛠️ What broke and what I learned

| Problem ❌ | Lesson ✅ |
|---|---|
| `redis-server: not found` during build | `RUN` runs at build time and processes don't carry over. Redis gets its own container. |
| `/count` returned **500** | A container started with plain `docker run` sits on the default network, where `redis` doesn't resolve. Use Compose. |
| `address already in use` on port 5000 | macOS AirPlay Receiver holds 5000. Found it with `lsof -i :5000` and moved to 5003. |
| `port is already allocated` on 5003 | An old `docker run` container held the port. `docker compose ps` only shows this project; `docker ps` shows everything. |
| `/count` gave **404**, `/counter` worked | Compose was running an old pre-built image. Switched to `build:` and checked with `docker compose exec web cat app.py`. |
| `version` is obsolete warning | Compose v2 ignores it, so I removed it. |

## 🎯 Bonus tasks

- [ ] Persistent Redis storage with a named volume
- [ ] Redis connection details from environment variables
- [ ] Scale Flask behind a load balancer

## 📋 Handy commands

```bash
docker compose logs web          # logs for one service
docker compose exec web <cmd>    # run a command inside a container
docker ps                        # all running containers
lsof -P -i :<port>               # what's holding a port?
```
