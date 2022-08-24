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

RUN rm -f  /usr/local/bin/docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/
RUN rm -f  /tmp/unicore-servers.tgz /tmp/configure.properties
COPY unicore-servers.tgz configure.properties /tmp/

EXPOSE 8080

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]
