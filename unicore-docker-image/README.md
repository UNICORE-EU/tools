# UNICORE all-in-one test installation in Docker

## Quickstart

This is a Docker container (based on Ubuntu) running an all-in-one
UNICORE server and the Slurm workload manager (https://slurm.schedmd.com/),
providing a one-node mini "cluster" and UNICORE services
to access it.

This container can be used for testing your UNICORE clients
and / or your workflows and applications.

It can also serve for evaluating UNICORE and its APIs.

To start the container in interactive mode:

```bash
docker run -p 8080:8080 -ti ghcr.io/unicore-eu/unicore-testing-all
```

or as a detached service

```bash
docker run -p 8080:8080 -d ghcr.io/unicore-eu/unicore-testing-all
```

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

You can also start the container using

```bash
make run
```

or in detached mode

```bash
make run-services
```


## Examples

You can download the UCC commandline client from SourceForge and use it
to access the endpoint(s) exposed by the container.


## Future work

Client tools IN the container will be provided in the future
