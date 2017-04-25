FROM httpd:2.4.25-alpine
RUN apk add --no-cache apache2-proxy openssh supervisor
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -A && echo "root:xebialabs" | chpasswd

CMD ["/usr/bin/supervisord"]
EXPOSE 22 80