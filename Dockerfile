# Use official NGINX image
FROM nginx:alpine

# Remove default nginx page and copy your HTML
COPY index.html /usr/share/nginx/html/index.html
