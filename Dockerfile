# Stage 1: Build the Hugo site
FROM klakegg/hugo:0.99.1-ext-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the Hugo project files into the container
COPY . .

# Build the Hugo site
RUN hugo
