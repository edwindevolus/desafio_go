FROM golang:alpine AS builder

WORKDIR /build
COPY hello.go .
RUN go mod init example/hello && \
    go build -ldflags="-s -w" -v -o hello hello.go

FROM scratch
WORKDIR /build
COPY --from=builder /build/hello /usr/local/bin/hello
CMD [ "hello" ]