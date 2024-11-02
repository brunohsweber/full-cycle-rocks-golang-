# Etapa de build
FROM golang:alpine AS build

# Configure o ambiente de trabalho
WORKDIR /app

# Copie o código fonte
COPY main.go .

# Inicie o módulo Go
RUN go mod init hello-world

# Compile o binário
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o hello

# Etapa final
FROM scratch

# Copie o binário compilado da etapa de build
COPY --from=build /app/hello /hello

# Defina o ponto de entrada
ENTRYPOINT ["/hello"]
