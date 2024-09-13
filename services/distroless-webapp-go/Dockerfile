FROM golang:1.20-alpine AS build

WORKDIR /app

COPY go.mod ./

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM gcr.io/distroless/base-debian11

WORKDIR /app
COPY --from=build /app/main ./

EXPOSE 4000

CMD ["/app/main"]
