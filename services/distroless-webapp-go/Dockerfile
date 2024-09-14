ARG BASE_IMAGE=gcr.io/distroless/base:nonroot

FROM golang:1.20 AS builder

ARG BASE_IMAGE

WORKDIR /app
COPY . ./
RUN BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ") && \
    go build -ldflags "-X 'main.baseImage=${BASE_IMAGE}' -X 'main.buildTime=${BUILD_TIME}'" -o main .

FROM ${BASE_IMAGE}

WORKDIR /app
COPY --from=builder /app/main .

USER nonroot
EXPOSE 4000
CMD ["./main"]
