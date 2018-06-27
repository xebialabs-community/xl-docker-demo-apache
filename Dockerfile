FROM httpd:2.4.33-alpine
MAINTAINER XebiaLabs "info@xebialabs.com"

RUN apk add --no-cache apache2 apache2-proxy openssh supervisor
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/sshd_config /etc/ssh/sshd_config
ADD resources/httpd.conf /usr/local/apache2/conf/httpd.conf
ADD resources/htdocs  /usr/local/apache2/htdocs
RUN ssh-keygen -A && echo "root:xebialabs" | chpasswd
RUN mkdir /usr/local/apache2/conf/custom

CMD ["/usr/bin/supervisord"]
EXPOSE 22 80