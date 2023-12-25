FROM golang:1.21

WORKDIR /src

RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/cosmtrek/air@latest

COPY . /src

CMD ["air"]
