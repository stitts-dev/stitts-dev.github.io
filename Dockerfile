# Use the official Alpine image as a base
FROM alpine:3.13

# Install dependencies: Git, Go, Node.js, npm, and wget
RUN apk add --no-cache git go nodejs npm wget

# Download and install Hugo
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

# Expose port 8080
EXPOSE 8080

# Command to run the Hugo server
CMD ["hugo", "server", "--bind", "0.0.0.0", "--baseURL=http://localhost:8080", "--appendPort=false"]