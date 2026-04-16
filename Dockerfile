FROM alpine:latest

RUN apk update && apk add --no-cache nginx

RUN mkdir -p /run/nginx /var/www/localhost/htdocs

RUN printf "%s\n" "<h1>Application Deployed via Terraform IaC!</h1>" > /var/www/localhost/htdocs/index.html

RUN cat > /etc/nginx/http.d/default.conf <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name localhost;

    root /var/www/localhost/htdocs;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]