FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN GCO_ENABLED=0 GOOS=linux go build -o /api-for-devops

FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=build /api-for-devops /api-for-devops

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/api-for-devops"]