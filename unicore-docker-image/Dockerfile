FROM ubuntu:22.04

RUN apt-get update -q

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    sudo nano less \
    hostname wget curl

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    hwloc make \
    munge slurmctld slurmd

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    python3-minimal \
    python3-requests \
    default-jre-headless \
    git


RUN rm -f /usr/local/bin/docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/
RUN rm -f /tmp/unicore-servers.tgz /tmp/configure.properties
COPY unicore-servers.tgz configure.properties /tmp/
COPY health-check.py /usr/local/bin/

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

HEALTHCHECK --interval=30s --timeout=10s --retries=10 \
 CMD python3 /usr/local/bin/health-check.py
