# Stage 1: Build stage
FROM alpine:latest AS build

# Install Go, Hugo, and Git
RUN apk add --update go hugo git

# Set the working directory
WORKDIR /opt/HugoApp

# Copy Hugo project files into the container
COPY . .

# Build the Hugo site to generate HTML
RUN hugo

# Stage 2: Serve stage
FROM nginx:1.25-alpine

# Set workdir to the NGINX default dir
WORKDIR /usr/share/nginx/html

# Copy the generated HTML files from the build stage
COPY --from=build /opt/HugoApp/public .

# Expose port 80
EXPOSE 80

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]