FROM golang:1.13.3 as builder
MAINTAINER "etcd Authors"

WORKDIR /tmp/go
COPY . .
RUN go mod download && \
    CGO_ENABLED=0 go build -a -ldflags '-s' -v

FROM scratch
EXPOSE 8087
CMD [ "/discoveryserver" ]
COPY --from=builder /tmp/go/discoveryserver /discoveryserver
