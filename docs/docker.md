# Docker

We can use Docker & Docker Compose to set up ${REPO_NAME}.

## Run ${REPO_NAME} on Docker Compose

Run it,

```sh
$ docker compose up
```

then Docker Compose do this:

- It runs ${REPO_NAME} using [github.com/go-delve/delve](https://github.com/go-delve/delve/) and [github.com/cosmtrek/air](https://github.com/cosmtrek/air/)
    - Hot reload enabled when editing `*.go` or `*.tpl`
    - delve runs on `:2345`
    - Optimal for Go Remote on GoLand. See also [GoLand blog](https://blog.jetbrains.com/go/2019/02/06/debugging-with-goland-getting-started/#debugging-a-running-application-on-a-remote-machine)
- It runs `go test` using [github.com/cosmtrek/air](https://github.com/cosmtrek/air/)
    - Hot reload enabled also 

