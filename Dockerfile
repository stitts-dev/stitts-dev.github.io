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
FROM nginx:alpine

# Copy the generated HTML files from the build stage
COPY --from=build /opt/HugoApp/public /usr/share/nginx/html

# Expose the port 80 (nginx default)
EXPOSE 80