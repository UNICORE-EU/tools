CONTAINER_NAME   = unicore-testing-all
VERSION          = 10.0.0
PATCH            = ""
CONTAINER_REPO   = ghcr.io/unicore-eu
CONTAINER        = $(CONTAINER_REPO)/$(CONTAINER_NAME)
CONTAINER_TAG    = $(CONTAINER):$(VERSION)
CONTAINER_LATEST = $(CONTAINER):latest
DOWNLOAD_URL     = "https://github.com/UNICORE-EU/server-bundle/releases/download/$(VERSION)$(PATCH)"

PORT = 8080

.DEFAULT_GOAL := build

.PHONY: build build-latest run clean realclean

unicore-servers.tgz:
	@echo "Downloading $(DOWNLOAD_URL)/unicore-servers-$(VERSION)$(PATCH).tgz ..."
	@wget --quiet $(DOWNLOAD_URL)/unicore-servers-$(VERSION)$(PATCH).tgz -O unicore-servers.tgz

build: unicore-servers.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_TAG) .

build-latest: unicore-servers.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_LATEST) .

run: build
	docker run -p ${PORT}:8080 -ti --rm $(CONTAINER):${VERSION}

run-services: build
	@echo "***"
	@echo "*** Starting UNICORE services on localhost:8080 ..."
	@echo "***"
	docker run -p ${PORT}:8080 -d --rm $(CONTAINER):${VERSION}

run-tsi-only: build
	@echo "***"
	@echo "*** Starting UNICORE Slurm TSI on localhost:4433 ..."
	@echo "***"
	$(eval DOCKERHOST=$(shell docker network inspect --format '{{range .IPAM.Config}}{{.Gateway}}{{end}}' bridge))
	docker run -p 4433:4433 -e "TSI_ONLY=true" --add-host dockerhost:$(DOCKERHOST) -d --rm $(CONTAINER):${VERSION}

clean:
	@find -name "*~" -delete

realclean: clean
	@rm -f *.tgz
