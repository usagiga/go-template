GO_BIN=go
EXEC_NAME=go-template

.PHONY: xxx
xxx:
	@echo "Please select optimal option."

.PHONY: build
build:
	@${GO_BIN} build -o ${EXEC_NAME} .

.PHONY: vendor
vendor:
	@${GO_BIN} mod vendor

.PHONY: clean
clean:
	@rm -f ./${EXEC_NAME}
	@rm -rf ./vendor

.PHONY: run
run:
	@${GO_BIN} run .

.PHONY: fmt
fmt:
	@${GO_BIN} fmt ./...

.PHONY: lint
lint:
	@${GO_BIN} vet ./...

.PHONY: test
test:
	@${GO_BIN} test -v ./...
