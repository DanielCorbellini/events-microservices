# Events - Run (quick steps)

Prerequisites

- Docker and Docker Compose installed

Steps (from project root)

1. Open terminal and enter in core folder

2. Build images:

   ```docker
   docker-compose build --no-cache
   ```

3. Start services in background:

   ```docker
   docker-compose up -d
   ```

4. Verify services:

   ```docker
   docker-compose ps
   ```

5. View logs (stream):

   ```docker
   docker-compose logs -f events-user-service
   ```

6. Access the user service:
   http://localhost:8081

7. Connect to Postgres:

   ```docker
   docker exec -it events-db bash
   ```

   ```shell
   psql -U postgres -d eventos
   ```

8. Stop and remove containers:

   ```docker
   docker-compose down
   ```

Rebuild only the user service after code changes:

```docker
docker-compose build --no-cache events-user-service
docker-compose up -d events-user-service
```
