# UFTP all-in-one test installation in Docker

## Quickstart

This is a Docker container (based on Ubuntu) running
UFTP (UNICORE FTP) servers.

This container can be used for testing your UFTP clients
and / or your workflows and applications.

It can also serve for evaluating UFTP and its APIs.

To start the container in interactive mode:

```bash
docker run -p 9000:9000 -p 64434:64434 -p 50000-500010:50000-50010 -ti ghcr.io/unicore-eu/uftp-testing-all
```

or as a detached service

```bash
docker run -p 9000:9000 -p 64434:64434 -p 50000-500010:50000-50010 -d ghcr.io/unicore-eu/uftp-testing-all
```

The container exposes UFTP Authserver and UFTP on localhost

  * Authserver https://localhost:9000/rest/auth
  * UFTP FTP port localhost:64434
  * UFTP data ports localhost 50000-50010

and can be accessed via username "demouser" and password "test123"


## Building the container

If you have Docker set up on your system, you can easily build the
container by executing `make`.  The first build may take a few
minutes.

The default name of the container is `uftp-testing-all`. If you
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

You can download the UFTP commandline client from SourceForge and use it
to access the endpoint(s) exposed by the container.

