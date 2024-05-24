# Stage 1: Build the Hugo site
FROM klakegg/hugo:0.99.1-ext-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the Hugo project files into the container
COPY . .

# Build the Hugo site
RUN hugo

# Stage 2: Serve the built Hugo site with Caddy
FROM caddy:alpine

# Copy the built site from the previous stage
COPY --from=builder /app/public /srv

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Expose port 80
EXPOSE 80

# Start the Caddy server
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]