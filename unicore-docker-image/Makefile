CONTAINER_NAME = unicore-testing-all
CONTAINER_TAG  = latest
CONTAINER      = $(CONTAINER_NAME):$(CONTAINER_TAG)
VERSION        = 8.3.0-p1

.PHONY: build run

unicore-servers.tgz:
	@wget https://sourceforge.net/projects/unicore/files/Servers/Core/$(VERSION)/unicore-servers-$(VERSION).tgz/download -O unicore-servers.tgz

build: unicore-servers.tgz Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER) .

run: build
	docker run --network host -ti --rm $(CONTAINER)

clean:
	@find -name "*~" -delete
