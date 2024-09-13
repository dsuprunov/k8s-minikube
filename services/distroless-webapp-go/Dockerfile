FROM golang:1.20-alpine AS build

WORKDIR /app

COPY go.mod ./

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

#FROM gcr.io/distroless/base:nonroot
FROM gcr.io/distroless/base

WORKDIR /app
COPY --from=build /app/main ./

#USER nonroot
EXPOSE 4000
CMD ["/app/main"]
