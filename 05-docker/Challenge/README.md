# Multi-Containers Challenge: Flask + Redis with Docker Compose

A multi-container application built as part of CoderCo.

A Python Flask web app uses a Redis database to count page visits, and both services run in their own containers, managed with Docker Compose.

## Architecture

```
            Browser
               │
     http://localhost:5003
               │
┌──────────────┼─────────────────────────────┐
│  Docker Compose network (challenge_default)│
│              ▼                             │
│     ┌─────────────────┐    redis:6379      │
│     │ web (Flask app) │ ─────────────────► │──┐
│     │ port 5003       │                    │  │
│     └─────────────────┘                    │  ▼
│                                ┌─────────────────┐
│                                │ redis           │
│                                │ key: "visits"   │
│                                └─────────────────┘
└────────────────────────────────────────────┘
```

- **web**: Flask app, built from the `Dockerfile` in the project root. It is the only service published to the host.
- **redis**: Redis key-value store. It is **not** published to the host; only the Flask container reaches it, over the internal Compose network.

The Flask app connects to Redis using the hostname `redis`. That works because Compose puts both containers on a shared network with built-in DNS, where each **service name** resolves to that container's IP address.

## Project structure

```
.
├── app.py               # Flask app with / and /count routes
├── requirements.txt     # Python dependencies (flask, redis)
├── Dockerfile           # Image for the Flask app
├── redis/
│   └── Dockerfile       # Image for Redis (based on the official image)
├── docker-compose.yml   # Defines and connects both services
├── .dockerignore        # Keeps unneeded files out of the build
└── README.md
```

## How to run

**Requirements:** Docker with the Compose plugin (`docker compose`).

```bash
# Build the images and start both containers
docker compose up --build

# In another terminal, check both services are running
docker compose ps

# Stop and remove the containers
docker compose down
```

## Endpoints

| URL | What it does |
|---|---|
| `http://localhost:5003/` | Shows a welcome message |
| `http://localhost:5003/count` | Increments the visit counter in Redis and shows the total |

Refresh `/count` and the number goes up each time.

## ⚠️ Deviation from the brief: port 5003 instead of 5000

The challenge tests on `localhost:5000`. This project uses **port 5003** instead.

**Why:** on macOS (Monterey and later), the **AirPlay Receiver** feature (`ControlCenter` process) listens on port 5000, so Docker can't bind to it. I chose to change the app's port rather than turn off a system feature.

To use port 5000, either turn off AirPlay Receiver (System Settings → General → AirDrop & Handoff), or keep the app on 5003 and change the host side of the port mapping in `docker-compose.yml` to `"5000:5003"`.

## Key design decisions

- **`INCR` for the counter**: Redis's `INCR` reads and increments in one atomic step, so the count stays correct even with several Flask instances running at once. A read-add-write approach could lose visits.
- **Flask binds to `0.0.0.0`**: the default (`127.0.0.1`) only accepts connections from inside the container itself, so the browser on the host couldn't reach it.
- **Dependencies installed before the code is copied**: Docker caches each layer, so editing `app.py` doesn't trigger a full reinstall of packages on every rebuild.
- **Redis not published to the host**: Redis has no password by default. Flask reaches it over the internal network, so publishing port 6379 would only expose the database for no benefit.
- **`build:` instead of `image:` for the web service**: Compose rebuilds the image from source, so code changes are picked up with `docker compose up --build`.

## Troubleshooting log: what broke and what I learned

| Problem | Cause | Fix / lesson |
|---|---|---|
| `redis-server: not found` during build | Tried to start Redis inside the Flask image with `RUN` | `RUN` runs at **build time** and processes don't carry over into the image. Redis belongs in its own container (one container, one job). |
| `/count` returned **500 Internal Server Error** | Flask was running in a container started with plain `docker run`, on Docker's default network, where the name `redis` doesn't resolve | Service-name DNS only works on a Compose (or user-defined) network. Run everything through Compose. |
| `bind: address already in use` on port 5000 | macOS AirPlay Receiver holds port 5000 | Found with `lsof -i :5000`. Moved the app to port 5003 (see above). |
| `Bind for 0.0.0.0:5003 failed: port is already allocated` | An old container from an earlier `docker run` still held port 5003 | `docker compose ps` only shows containers in the current project. `docker ps` shows all of them. Stopped and removed the stray container. |
| `/count` gave **404** but `/counter` worked | Compose used an old, pre-built image (`image: challenge`) with the old route name, so `--build` had nothing to rebuild | Switched the web service to `build:`. Checked the code inside the container with `docker compose exec web cat app.py`. |
| Warning: `the attribute version is obsolete` | The `version:` key is no longer used by Compose v2 | Removed it. |

## Bonus tasks

- [ ] **Persistent storage**: named volume for Redis data, so the count survives `docker compose down`
- [ ] **Environment variables**: read the Redis host and port from env vars instead of hard-coding them
- [ ] **Scaling**: run multiple Flask instances behind a load balancer (e.g. NGINX)

## Useful commands

```bash
docker compose up --build        # build and start
docker compose ps                # services in this project
docker ps                        # all running containers on the machine
docker compose logs web          # logs for one service
docker compose exec web <cmd>    # run a command inside a running container
lsof -P -i :<port>               # find which process holds a port (macOS/Linux)
```
