CONTAINER_NAME = unicore-testing-all
VERSION        = 8.3.0-p1
CONTAINER_REPO = ghcr.io/unicore-eu
CONTAINER      = $(CONTAINER_REPO)/$(CONTAINER_NAME)
CONTAINER_TAG1  = $(CONTAINER):$(VERSION)
CONTAINER_TAG2  = $(CONTAINER):latest


.PHONY: build run

unicore-servers.tgz:
	@wget https://sourceforge.net/projects/unicore/files/Servers/Core/$(VERSION)/unicore-servers-$(VERSION).tgz/download -O unicore-servers.tgz

build: unicore-servers.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER_TAG1) -t $(CONTAINER_TAG2) .

run: build
	docker run -p 8080:8080 -ti --rm $(CONTAINER)

clean:
	@find -name "*~" -delete
