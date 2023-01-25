FROM golang:1.19-alpine as builder

WORKDIR /app

COPY . /app

RUN CGO_ENABLED=0 GOOS=linux go build -o docker_go main.go

RUN go build -o /app .

FROM scratch

WORKDIR /

COPY --from=builder /app .

CMD [ "./docker_go" ]