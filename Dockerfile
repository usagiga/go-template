#syntax=docker/dockerfile:1.7-labs

ARG BUILD_BASE="golang"
ARG BUILD_BASE_VERSION="1.22.4-bookworm"

ARG PROD_BASE="gcr.io/distroless/base-debian12"
ARG PROD_BASE_VERSION="nonroot"

ARG DEV_BASE="${PROD_BASE}"
ARG DEV_BASE_VERSION="debug-nonroot"

# Prepare Sources
FROM ${BUILD_BASE}:${BUILD_BASE_VERSION} as src
WORKDIR /src

# go.mod / go.sum
COPY ["go.*", "./"]
RUN go mod download

COPY --parents ["**/*.go", "Makefile", "./"]

# Build (Development)
FROM src as build_dev

# To build faster, installing delve partially
RUN go install github.com/go-delve/delve/cmd/dlv@latest

# to use delve, disable optimizations/inlining
ENV GCFLAGS="all=-N -l"
RUN make build

# Build (Production)
FROM src as build_prod
RUN make build

# Runner (Development)
FROM ${DEV_BASE}:${DEV_BASE_VERSION} as dev

WORKDIR /src

EXPOSE 2345

COPY --from=build_dev ["/go/bin/dlv", "/usr/bin/"]
COPY --from=build_dev ["/src/go-template", "./"]

ENTRYPOINT ["dlv", "--listen=:2345", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "./go-template"]

# Runner (Go Test)
FROM build_dev as test

WORKDIR /src

EXPOSE 2346

# Run all tests
# To test as you need, overwrite CMD
ENTRYPOINT ["dlv", "--listen=:2346", "--headless=true", "--api-version=2", "--accept-multiclient", "test", "--"]
CMD ["-test.v", "./..."]

# Runner (Production)
FROM ${PROD_BASE}:${PROD_BASE_VERSION} as prod
WORKDIR /src

COPY --from=build_prod ["/src/go-template", "./"]

ENTRYPOINT ["./go-template"]
