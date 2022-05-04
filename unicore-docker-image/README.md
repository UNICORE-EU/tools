# UNICORE all-in-one test installation in Docker

WORK IN PROGRESS!

## Quickstart

This is a Docker container (based on Ubuntu) running UNICORE and
Slurm.  This container can be used for testing your UNICORE clients
and / or your workflows and applications.

It can also serve for evaluating UNICORE and its APIs.

To start the container:

```bash
 make build
 make run
```

the first invocation of "make build" may take a couple minutes.

The container exposes UNICORE REST APIs on localhost

  * https://localhost:8080/DEMO-SITE/rest/core

and can be accessed via username "demouser" and password "test123"



## Setup

The container runs an all-in-one UNICORE server
and uses Slurm to provide a single "compute node".

TBD client tools
  * ucc (UNICORE commandline client)
  * uftp (UFTP client)
  * pyunicore (Python client library)

When you start the container, the services are already up and running,
and the container runs a shell as `demouser`.

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

You can download the UCC commandline client from sourceforge and use it
to access the endpoint(s) exposed by the container.

TBD client tools IN the container will be provided in the future

