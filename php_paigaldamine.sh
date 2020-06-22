PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
if [ $PHP -eq 0 ]; then
	echo "Paigaldame PHP ja vajalikud lisad"
	apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "php on paigaldatud"
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba paigaldatud"
	which php
fi
