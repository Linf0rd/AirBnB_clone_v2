#!/usr/bin/env bash

# This script sets up web servers for the deployment of web_static.

if ! command -v nginx &> /dev/null; then
  sudo apt update
  sudo apt install nginx -y
fi

sudo mkdir -p /data/web_static/{releases,shared} /data/web_static/releases/test
sudo chown -R ubuntu:ubuntu /data

sudo sh -c "echo '<html><body>Holberton School</body></html>' > /data/web_static/releases/test/index.html"

sudo rm -rf /data/web_static/current
sudo ln -s /data/web_static/releases/test /data/web_static/current

sudo sh -c 'echo "server {
  location /hbnb_static {
    alias /data/web_static/current/;
    index index.html;
  }
}" > /etc/nginx/sites-available/hbnb_static.conf'
sudo ln -s /etc/nginx/sites-available/hbnb_static.conf /etc/nginx/sites-enabled/

sudo systemctl restart nginx
