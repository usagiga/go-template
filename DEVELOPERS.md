# ${REPO_NAME} Development Guide

This document aims to prepare your development environment for ${REPO_NAME}.

## Setup

## Install Dependencies

- Go >= 1.22.4
  - (Recommended) [proto](https://moonrepo.dev/proto) for managing runtime
- Docker
  - Ensure some features
    - [Compose Spec](https://www.compose-spec.io/)
    - `compose watch`
    - `sync+restart`
    - `COPY --parents` with Dockerfile 1.7-lab
    - (Optional) BuildKit
- Git

<details>

<summary>Detailed Docker Install Instruction</summary>

In ArchLinux, install these packages:

- https://archlinux.org/packages/extra/x86_64/docker/
- https://archlinux.org/packages/extra/x86_64/docker-compose/
- https://archlinux.org/packages/extra/x86_64/docker-buildx/

As a shorthand, run it:

```sh
$ pacman -S docker docker-compose docker-buildx

$ sudo systemctl enable docker
$ sudo systemctl start docker
```

See details: [Docker - ArchWiki](https://wiki.archlinux.org/title/Docker)

In the other distros/platforms, please ensure that Docker toolchains are installed enabled features described above.

For example, the author is using this versions.
Set up these versions or higher :pray:

```sh
# Docker CLI / Engine
$ docker version
Client:
 Version:           26.1.4
 API version:       1.45
 Go version:        go1.22.3
 Git commit:        5650f9b102
 Built:             Thu Jun  6 18:42:55 2024
 OS/Arch:           linux/amd64
 Context:           default

Server:
 Engine:
  Version:          26.1.4
  API version:      1.45 (minimum version 1.24)
  Go version:       go1.22.3
  Git commit:       de5c9cf0b9
  Built:            Thu Jun  6 18:42:55 2024
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.7.18
  GitCommit:        ae71819c4f5e67bb4d5ae76a6b735f29cc25774e.m
 runc:
  Version:          1.1.12
  GitCommit:
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

# Docker Compose
$ docker compose version
Docker Compose version 2.27.1

# BuildKit
$ docker buildx inspect
Name:          default
Driver:        docker
Last Activity: 2024-06-17 08:26:09 +0000 UTC

Nodes:
Name:             default
Endpoint:         default
Status:           running
BuildKit version: v0.13.2
Platforms:        linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
Labels:
 org.mobyproject.buildkit.worker.moby.host-gateway-ip: 172.17.0.1
```

</details>

### Optional Dependencies

- GNU Make
- EditorConfig
- Frontend for [delve](https://github.com/go-delve/delve) (i.e. IDEs)
- Additional Linter / Vulnerability Checker
  - hadolint
  - Dockle
  - Trivy
  - actionlint
- (Recommended) GoLand (Jetbrains IDE)
  - (TBU) Several run configurations are available
    - See also: [GoLand blog](https://blog.jetbrains.com/go/2019/02/06/debugging-with-goland-getting-started/#debugging-a-running-application-on-a-remote-machine)

# Build Binary

```sh
$ make build
```

# Build Production Image

```sh
$ make build_image
```

# Run a Development Build Locally with Debugger

```sh
$ make watch_dev
```

This command prepares containers based on distroless:debug,
then build/run binary with [delve](https://github.com/go-delve/delve) on `:2345`.
And then, enabled hot reload using Compose Watch (rebuild mode),
so that ensure to prune dangling images / networks / build caches manually.

# Run a Go Test with Debugger

```sh
$ make watch_test
```

This command prepares containers based on golang official image,
then run `go test -v ./...` with [delve](https://github.com/go-delve/delve) on `:2346`.
And then, enabled hot reload using Compose Watch (`sync+restart` mode).

:warning: This instruction uses the port **2346**. It is not default of delve.

If you want to change arguments of `go test`, override it using Docker `CMD` instruction. Such as:

- `docker compose run [SERVICE] [COMMAND] [ARGS]`
- `commands` in `compose.yml`
  - [Extend your Compose file | Docker Docs](https://docs.docker.com/compose/multiple-compose-files/extends/)


# How to Use This Template

- Replace variables
  - `${REPO_NAME}` -> Repository Name
  - `${REPO_DESC}` -> Repository Description
  - `go-template` -> Name of binary / package / repository
- NOW GO :running: :dash:
