# Use the official Alpine image as a base
FROM alpine:3.13

# Install dependencies: Git, Node.js, npm, Go, and wget
RUN apk add --no-cache git nodejs npm go wget

# Download and install Hugo (specify the version you want, e.g., 0.115.0)
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.115.0/hugo_extended_0.115.0_Linux-64bit.tar.gz \
    && tar -xzvf hugo_extended_0.115.0_Linux-64bit.tar.gz \
    && mv hugo /usr/local/bin/ \
    && rm hugo_extended_0.115.0_Linux-64bit.tar.gz

# Set the working directory
WORKDIR /src

# Copy the source files
COPY . .

# Install npm dependencies
RUN npm install

# Expose port 6969
EXPOSE 6969

# Command to run the Hugo server
CMD ["hugo", "server", "--bind", "0.0.0.0", "--baseURL=http://localhost:6969", "--appendPort=false"]