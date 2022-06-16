FROM golang:1.16.1 AS builder
RUN go version

COPY . /go/src/github.com/devopstales/k8s-image-build-demo/
WORKDIR /go/src/github.com/devopstales/k8s-image-build-demo/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o app .

FROM scratch
WORKDIR /root/
COPY --from=builder /go/src/github.com/devopstales/k8s-image-build-demo/app .

EXPOSE 8080
ENTRYPOINT ["./app"]