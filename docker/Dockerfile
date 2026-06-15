FROM nginx:stable-alpine

# Copy a minimal site that includes /healthz endpoint
COPY index.html /usr/share/nginx/html/index.html
COPY healthz /usr/share/nginx/html/healthz

EXPOSE 80
