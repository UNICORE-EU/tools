FROM ubuntu:21.04

RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -m -y \
    sudo nano less hostname hwloc wget tree telnet \
    cmake make pkgconf \
    munge slurm slurmctld slurmd \
    python3 python3-pip \
    git \
    default-jre-headless

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

