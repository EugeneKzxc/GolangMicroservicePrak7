FROM golang:latest AS builder

WORKDIR /app

COPY /go.mod /go.sum ./
RUN go mod download

COPY / ./

RUN CGO_ENABLED=0 GOOS=linux go build -o sub-server .

FROM alpine
COPY --from=builder /app/sub-server /sub-server
ENTRYPOINT ["/sub-server"]
