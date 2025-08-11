FROM ubuntu:24.04

RUN apt-get update -q

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    sudo nano less hostname

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    python3-minimal python3-requests default-jre-headless 

RUN rm -f /usr/local/bin/docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/
RUN rm -f /tmp/unicore-authserver.tgz unicore-uftpd.tgz
COPY unicore-authserver.tgz unicore-uftpd.tgz /tmp/
COPY health-check.py /usr/local/bin/

EXPOSE 9000
EXPOSE 64434
EXPOSE 50000-50050

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

HEALTHCHECK --interval=30s --timeout=10s --retries=10\
 CMD python3 /usr/local/bin/health-check.py