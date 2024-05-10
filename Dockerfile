FROM golang:1.22.3-alpine3.19

RUN apk add --no-cache --upgrade bash

# On construit l'app
WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY main.go .
COPY pkg/postgresql/client.go pkg/postgresql/
RUN go build -v -o /usr/local/bin/. ./...
COPY start.sh /usr/local/bin/

WORKDIR /usr/local/bin/
CMD [ "./start.sh" ]

