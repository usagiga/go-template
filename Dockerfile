FROM golang:1.19

WORKDIR /go/src/github.com/usagiga/git-hooks

RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/cosmtrek/air@latest

COPY . /go/src/github.com/usagiga/git-hooks

CMD ["air"]
