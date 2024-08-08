FROM ubuntu:22.04

RUN apt-get update -q

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    sudo nano less \
    hostname wget curl

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    hwloc make \
    munge slurm slurmctld slurmd

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -q -m -y \
    python3-minimal \
    default-jre-headless \
    git

#RUN mkdir /sys/fs/cgroup/system.slice

RUN rm -f  /usr/local/bin/docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/
RUN rm -f  /tmp/unicore-servers.tgz /tmp/configure.properties
COPY unicore-servers.tgz configure.properties /tmp/

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

HEALTHCHECK --interval=30s --timeout=10s --retries=10 \
 CMD curl -k -s -f -X OPTIONS https://localhost:8080/DEMO-SITE/rest/core || exit 1
