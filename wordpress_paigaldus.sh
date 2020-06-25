
#apache
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $APACHE2 -eq 0 ]; then
        echo "paigaldame apache2"
        apt install apache2
        echo "apache2 on paigaldatud"
elif [ $APACHE2 -eq 1 ]; then
        echo "apache2 on juba paigaldatud"
        service apache2 start
        service apache2 status
fi

#php
PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
if [ $PHP -eq 0 ]; then
	echo "Paigaldame PHP ja vajalikud lisad"
	apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "php on paigaldatud"
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba paigaldatud"
	which php
fi

#mysql
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')

if [ $MYSQL -eq 0 ]; then
	echo "Paigaldame MySQL ja vajalikud lisad"
	apt install mysql-server
	echo "MySQL on paigaldatud"
	touch $HOME/.my.cnf
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
elif [ $MYSQL -eq 1 ]; then
	echo "MYSQL server on juba olemas"
	mysql
fi

#mysql database

mysql <<EOF
create database wordpress;
create user 'wordpressuser'@'localhost' identified by 'password';
grant all privileges on wordpress.* to 'wordpressuser'@'localhost';
flush privileges;
show databases;
select now();
EOF

#pma 

PMA=$(dpkg-query -W -f='{$Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
if [ $PMA -eq 0 ]; then
	echo "Paigaldame phpmyadmin ja vajalikud lisad"
	apt install phpmyadmin 
	echo "phpmyadmin on paigaldatud"
elif [ $PMA -eq 1 ]; then
	echo "phpmyadmin on juba paigaldatud"
fi

#wp

echo "Wordpressi  paigaldus"
wget https://wordpress.org/latest.tar.gz 
tar xzvf /var/www/html/latest.tar.gz  
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php




