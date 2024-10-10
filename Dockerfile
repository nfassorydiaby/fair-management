FROM golang:latest

WORKDIR /app
COPY ./backend .

# Vider le cache Go
RUN go clean -cache -modcache -i -r

RUN go mod tidy
RUN go mod download

RUN cd cmd && go build -o main .

EXPOSE 8080

CMD ["./cmd/main"]


