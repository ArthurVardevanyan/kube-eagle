# build image
FROM docker.io/golang:1.22.5 as builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/kube-eagle

# executable image
FROM scratch
COPY --from=builder /go/bin/kube-eagle /go/bin/kube-eagle

ENV VERSION 1.1.10
ENTRYPOINT ["/go/bin/kube-eagle"]
