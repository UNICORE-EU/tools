CONTAINER_NAME = unicore-testing-all
CONTAINER_TAG  = latest
CONTAINER      = $(CONTAINER_NAME):$(CONTAINER_TAG)

.PHONY: build run

build: Dockerfile docker-entrypoint.sh
	docker build -t $(CONTAINER) .

run: build
	docker run --network host -ti --rm $(CONTAINER)

clean:
	@find -name "*~" -delete
