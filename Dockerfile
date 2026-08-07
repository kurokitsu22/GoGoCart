services:
  app:
    build:
      context: ./
      dockerfile: Dockerfile
    container_name: my-app
    restart: unless-stopped

    env_file:
      - ./.env

    ports:
      - "8080:8080" 

    depends_on:
      - postgres

    volumes:
      - ./:/app

    networks:
      - app-network

  postgres:
    image: postgres:16-alpine
    container_name: postgres-db
    restart: unless-stopped

    env_file:
      - .env

    ports:
      - "5432:5432"

    volumes:
      - postgres-data:/var/lib/postgresql/data

    networks:
      - app-network

networks:
  app-network:
    external: true

volumes:
  postgres-data: