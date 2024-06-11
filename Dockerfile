# Stage 1: Build the Hugo site
FROM klakegg/hugo:0.42-alpine-onbuild AS builder

WORKDIR /app
COPY . .

RUN hugo -D

# Stage 2: Serve the built Hugo site with nginx
FROM nginx:alpine

COPY --from=builder /app/public /usr/share/nginx/site
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod -R 755 /usr/share/nginx/site

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
