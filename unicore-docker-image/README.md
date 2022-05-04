# UNICORE all-in-one test installation in Docker

WORK IN PROGRESS!

## Quickstart

This is a Docker container (based on Ubuntu) running an all-in-one
UNICORE server and the Slurm workload manager (https://slurm.schedmd.com/)

This container can be used for testing your UNICORE clients
and / or your workflows and applications.

It can also serve for evaluating UNICORE and its APIs.

The container runs an all-in-one UNICORE server
and uses Slurm to provide a single "compute node".

To start the container:

```bash
 make build
 make run
```

(the first invocation of "make build" may take a couple minutes.)

The container exposes UNICORE REST APIs on localhost

  * UNICORE/X https://localhost:8080/DEMO-SITE/rest/core
  * Workflow https://localhost:8080/DEMO-SITE/rest/workflows
  * Registry https://localhost:8080/DEMO-SITE/rest/registries/default_registry

and can be accessed via username "demouser" and password "test123"


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


## Future work

Client tools IN the container will be provided in the future

