#!/usr/bin/env bash
# Deploy AirBNB static files

apt-get install nginx
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
res="<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>"
echo "$res" | sudo tee /data/web_static/releases/test/index.html > /dev/null
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data/
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bkp
echo "server {
	listen 80 default_server;
	listen [::]:80 default_server;



	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

    location /hbnb_static/ {
        alias /data/web_static/current/;
    }
	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files \$uri \$uri/ =404;
	}

}" | tee /etc/nginx/sites-available/default > /dev/null

service nginx restart
exit 0