CONTAINER_NAME = uftp-testing-all
VERSION        = 3.3.0
AUTHVERSION    = 2.8.2
PATCH          = ""
CONTAINER_REPO = ghcr.io/unicore-eu
CONTAINER      = $(CONTAINER_REPO)/$(CONTAINER_NAME)
CONTAINER_TAG  = $(CONTAINER):$(VERSION)
CONTAINER_LATEST = $(CONTAINER):latest

# ports for running the services
AUTH_PORT = 9000
UFTP_PORT = 64434

.DEFAULT_GOAL := build

.PHONY: build run clean

unicore-authserver.tgz:
	@echo "Downloading Auth server ${AUTHVERSION} ..."
	@wget --quiet https://sourceforge.net/projects/unicore/files/Servers/UFTP-AuthServer/$(AUTHVERSION)/unicore-authserver-$(AUTHVERSION)-1.tar.gz/download -O unicore-authserver.tgz

unicore-uftpd.tgz:
	@echo "Downloading UFTPD ${VERSION} ..."
	@wget --quiet https://sourceforge.net/projects/unicore/files/Servers/UFTPD/$(VERSION)/unicore-uftpd-$(VERSION)-1.tar.gz/download -O unicore-uftpd.tgz

build: unicore-authserver.tgz unicore-uftpd.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_TAG) .

build-latest: unicore-authserver.tgz unicore-uftpd.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_LATEST) .

run: build
	docker run -p $(AUTH_PORT):9000 -p $(UFTP_PORT):64434 -p 50000-50050:50000-50050 -ti --rm $(CONTAINER):${VERSION}

run-services: build
	@echo "***"
	@echo "*** Starting UNICORE Authserver localhost:9000 ..."
	@echo "***"
	docker run -p $(AUTH_PORT):9000 -p $(UFTP_PORT):64434 -p 50000-50050:50000-50050 -d --rm $(CONTAINER):${VERSION}

clean:
	@find -name "*~" -delete

realclean: clean
	@rm -f *.tgz

