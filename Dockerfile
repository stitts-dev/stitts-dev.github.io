# Stage 1: Build the Hugo site
FROM klakegg/hugo:0.42-alpine-onbuild AS builder

# Set the working directory
WORKDIR /app

# Copy the Hugo project files into the container
COPY . .

# Build the Hugo site
RUN hugo -D

# Stage 2: Serve the built Hugo site with nginx
FROM nginx:alpine

# Copy the built site from the previous stage
COPY --from=builder /app/public /usr/share/nginx/site

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set permissions
RUN chmod -R 755 /usr/share/nginx/site

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]