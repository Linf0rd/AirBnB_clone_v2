#!/usr/bin/env bash
# This script sets up web servers for the deployment of web_static.

if ! command -v nginx &> /dev/null; then
  sudo apt-get update -y
  sudo apt-get install nginx -y
fi

sudo ufw allow 'Nginx HTTP'
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
sudo chown -hR ubuntu:ubuntu /data

sudo sh -c "echo '<html><body>Holberton School</body></html>' > /data/web_static/releases/test/index.html"

sudo rm -rf /data/web_static/current
sudo ln -sf /data/web_static/releases/test /data/web_static/current

sudo sh -c 'echo "server {
  location /hbnb_static {
    alias /data/web_static/current/;
    index index.html;
  }
}" > /etc/nginx/sites-available/default'
sudo ln -sf '/etc/nginx/sites-available/default' '/etc/nginx/sites-enabled/default'

sudo service nginx restart
