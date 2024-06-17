GO_BIN=go
DELVE_BIN=delve
DOCKER_BIN=docker
EXEC_NAME=go-template

.PHONY: xxx
xxx:
	@echo "Please select optimal option."

#####
# Go
#####

.PHONY: build
build:
	${GO_BIN} build -o ${EXEC_NAME} .

.PHONY: vendor
vendor:
	${GO_BIN} mod vendor

.PHONY: clean
clean:
	rm -f ./${EXEC_NAME}
	rm -rf ./vendor

.PHONY: run
run:
	${GO_BIN} run .

.PHONY: fmt
fmt:
	${GO_BIN} fmt ./...

.PHONY: lint
lint:
	${GO_BIN} vet ./...
	${GO_BIN} mod velify

.PHONY: test
test:
	${GO_BIN} test -v ./...

#####
# Docker / Compose
#####

.PHONY: watch
watch:
	${DOCKER_BIN} compose --profile dev --profile test watch

.PHONY: watch_dev
watch_dev:
	${DOCKER_BIN} compose --profile dev watch

.PHONY: watch_test
watch_test:
	${DOCKER_BIN} compose --profile test watch

.PHONY: prune
prune_image:
	${DOCKER_BIN} image prune

.PHONY: build_image
build_image:
	${DOCKER_BIN} build --tag yagisan --target prod .
