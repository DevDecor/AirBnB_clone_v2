#!/usr/bin/env bash
# Deploy AirBNB static files

#!/usr/bin/env bash
# Script that setup a nginx web server on our server + redirection + 404.

apt update -y && apt upgrade -y
apt install nginx -y

# Index page
# echo "Holberton School" >/var/www/html/index.nginx-debian.html
echo "Hello World!" | sudo tee /var/www/html/index.html > /dev/null 

# Redirect to fabulous Rick Astley page
# sed -i '/listen \[::\]:80 default_server;/a\        rewrite ^\/redirect_me https://www.youtube.com/watch?v=dQw4w9WgXcQ permanent;' /etc/nginx/sites-available/default

# 404 Page not Found
echo "Ceci n'est pas une page" >/var/www/html/404.html
# sed -i '/dQw4w9WgXcQ permanent;$/a\        error_page 404 /404.html;' /etc/nginx/sites-available/default



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
echo "$res" | sudo dd status=none of=/data/web_static/releases/test/index.html > /dev/null
rm -rf /data/web_static/current
ln -sf /data/web_static/releases/test /data/web_static/current
# ln -sf /data/web_static/releases/test /var/www/html/hbnb_static
chown -R ubuntu:ubuntu /data/
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bkp
route=\
"
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# rewrite ^\/redirect_me https://www.youtube.com/watch?v=dQw4w9WgXcQ permanent;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

    location /hbnb_static {
        alias /data/web_static/current/;
        index index.html;
    }

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files \$uri \$uri/ =404;
	}
	# error_page 404 /404.html;

}"
echo "$route" | sudo dd status=none of=/etc/nginx/sites-available/default > /dev/null

service nginx restart
exit 0