# build image
FROM golang:1.11-alpine as builder
RUN apk update && apk add git ca-certificates

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -installsuffix cgo -o /go/bin/kube-eagle

# executable image
FROM scratch
COPY --from=builder /go/bin/kube-eagle /go/bin/kube-eagle

ENV VERSION 1.0.2
ENTRYPOINT ["/go/bin/kube-eagle"]
