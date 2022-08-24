CONTAINER_NAME = unicore-testing-all
VERSION        = 8.3.0
PATCH          = "-p1"
CONTAINER_REPO = ghcr.io/unicore-eu
CONTAINER      = $(CONTAINER_REPO)/$(CONTAINER_NAME)
CONTAINER_TAG  = $(CONTAINER):$(VERSION)

.DEFAULT_GOAL := build

.PHONY: build run clean

unicore-servers.tgz:
	@wget --quiet https://sourceforge.net/projects/unicore/files/Servers/Core/$(VERSION)$(PATCH)/unicore-servers-$(VERSION)$(PATCH).tgz/download -O unicore-servers.tgz

build: unicore-servers.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_TAG) .

run: build
	docker run -p 8080:8080 -ti --rm $(CONTAINER):${VERSION}

run-services: build
	@echo "***"
	@echo "*** Starting UNICORE services on localhost:8080 ..."
	@echo "***"
	docker run -p 8080:8080 -d --rm $(CONTAINER):${VERSION}

clean:
	@find -name "*~" -delete
