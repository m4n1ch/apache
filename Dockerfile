FROM centos:7

RUN yum -y install httpd php php-xml php-mbstring php-intl php-mysql php_ldap php-pear wget tar
RUN pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime

RUN wget "https://github.com/roundcube/roundcubemail/releases/download/1.2.3/roundcubemail-1.2.3-complete.tar.gz" -O roundcubemail.tar.gz
RUN tar xf roundcubemail.tar.gz -C /var/www/html --strip-components 1
RUN rm roundcubemail.tar.gz

ADD config.inc.php /var/www/html/config/config.php

EXPOSE 80


ADD run-httpd.sh /run-httpd.sh
RUN sed -i -e 's/\r$//' /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

RUN chmod 777 /var/www/html/temp/
RUN chmod 777 /var/www/html/logs/

CMD ["/run-httpd.sh"]