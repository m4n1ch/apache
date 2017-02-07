FROM centos:7
RUN yum -y install httpd php php-xml php-mbstring php-intl php-mysql php_ldap php-pear wget tar telnet
RUN pear install Auth_SASL Net_SMTP Net_IDNA2-0.1.1 Mail_mime
EXPOSE 80
ADD run-httpd.sh /run-httpd.sh
RUN sed -i -e 's/\r$//' /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
CMD ["/run-httpd.sh"]
