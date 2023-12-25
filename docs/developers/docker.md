# Docker

We can use Docker & Compose to set it up that developing environment for ${REPO_NAME}.

## Run ${REPO_NAME} on Docker Compose

Run it,

```sh
$ docker compose up
```

then Docker Compose do this:

- Run ${REPO_NAME}
- Run `go test`

### Features

- Hot reload is enabled when editing `*.go` or `*.tpl`
  - using [github.com/cosmtrek/air](https://github.com/cosmtrek/air/)
- Debugger running on `:2345`
  - using [github.com/go-delve/delve](https://github.com/go-delve/delve)
- (for GoLand) Default run / debug configuration is available
    - See details
      - [GoLand blog](https://blog.jetbrains.com/go/2019/02/06/debugging-with-goland-getting-started/#debugging-a-running-application-on-a-remote-machine)
      - Configuration [/.idea/runConfigurations/delve_on_docker.xml](../../.idea/runConfigurations/delve_on_docker.xml)
