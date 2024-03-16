FROM golang:1.22.0-alpine AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o cc_editor_server .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/cc_editor_server .

EXPOSE 8000

CMD ["./cc_editor_server"]
