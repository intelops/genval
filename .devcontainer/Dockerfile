
ARG GO_VERSION=1.21
ARG ALPINE_VERSION=3.19

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION}


# Install packages and Go language server
RUN apk add -q --update --progress --no-cache git sudo openssh-client make
RUN go install golang.org/x/tools/gopls@latest 2>&1