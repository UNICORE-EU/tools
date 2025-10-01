CONTAINER_NAME   = uftp-testing-all
VERSION          = 3.5.2
UFTPDVERSION     = 3.5.1
AUTHVERSION      = 3.2.0
PATCH            = ""
CONTAINER_REPO   = ghcr.io/unicore-eu
CONTAINER        = $(CONTAINER_REPO)/$(CONTAINER_NAME)
CONTAINER_TAG    = $(CONTAINER):$(VERSION)
CONTAINER_LATEST = $(CONTAINER):latest
DOWNLOAD_AUTH    = "https://github.com/UNICORE-EU/uftp/releases/download/authserver-$(AUTHVERSION)"
DOWNLOAD_UFTPD   = "https://github.com/UNICORE-EU/uftpd/releases/download/$(UFTPDVERSION)"

# ports for running the services
AUTH_PORT = 9000
UFTP_PORT = 64434

.DEFAULT_GOAL := build

.PHONY: build build-latest run clean realclean

unicore-authserver.tgz:
	@echo "Downloading $(DOWNLOAD_AUTH)/unicore-authserver-$(AUTHVERSION)-1.tar.gz  ..."
	@wget --quiet $(DOWNLOAD_AUTH)/unicore-authserver-$(AUTHVERSION)-1.tar.gz -O unicore-authserver.tgz

unicore-uftpd.tgz:
	@echo "Downloading $(DOWNLOAD_UFTPD) ..."
	@wget --quiet $(DOWNLOAD_UFTPD)/unicore-uftpd-$(UFTPDVERSION)-1.tar.gz -O unicore-uftpd.tgz

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
