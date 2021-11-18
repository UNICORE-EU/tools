# UNICORE all-in-one test installation in Docker

WORK IN PROGRESS!

This is a Docker container (based on Ubuntu) running UNICORE and
Slurm.  This container can be used for testing your UNICORE clients
and / or your workflows and applications.

It can also serve for evaluating UNICORE and its APIs.

## Setup

The container runs an all-in-one UNICORE server
and uses Slurm to provide a single "compute node".

It also comes pre-installed with client tools
  * ucc (UNICORE commandline client)
  * uftp (UFTP client)
  * pyunicore (Python client library)

When you start the container, the services are already up and running,
and the container runs a shell as `demouser`.

## Running the container

If you don't want to build the container yourself, you can pull it from ...


```bash
 # todo
```

To run the container use this command:

```bash
docker run -ti --network host --rm unicore-testing-all
```

## Building the container

If you have Docker set up on your system, you can easily build the
container by executing `make`.  The first build may take a few
minutes.

The default name of the container is `unicore-testing-all`. If you
want to choose a shorter name, you can pass it as an argument when
building the container, e.g.

```bash
make CONTAINER_NAME=test
```

Verify the build worked:

```bash
docker image ls
```

## Examples

Inside the container, a couple of example jobs and workflows
are available in /opt/unicore/examples


