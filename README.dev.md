# Development with Docker

Local development environment using Docker.

---

## 🚀 First-Time Setup (One Command)

```bash
./bin/docker-setup
```

App will be at **http://localhost:3000** ✅

---

## 🔧 Running the App

### Recommended: With Live Reload
```bash
docker compose watch
```

### Without Live Reload
```bash
docker compose up
```

---

## 📝 Running Rails Commands

```bash
# Rails console
docker compose exec web bundle exec rails console

# Database migrations
docker compose exec web bundle exec rails db:migrate

# Run tests
docker compose exec web bundle exec rails test

# Open a shell in the container
docker compose exec web bash
```

---

## 🛑 Stopping & Resetting

```bash
# Stop containers
docker compose down

# Stop and remove database (fresh start)
docker compose down -v
./bin/docker-setup
```

---

## 🔄 After Updating Code

### If you changed `Gemfile`:
```bash
docker compose up --build
```

### If you pulled new migrations:
```bash
docker compose exec web bundle exec rails db:migrate
```

### If something feels broken:
```bash
docker compose down -v
./bin/docker-setup
```

---

## 🔐 About Your Database Password

- `db/password.txt` — Your local password (never commit this)
- `db/password.txt.example` — Template (for reference)
- Each developer creates their own in the setup step
