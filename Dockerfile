# FROM golang:1.22.1-alpine3.18 AS builder

# RUN mkdir app

# COPY . .

# WORKDIR /app

# RUN go build -o main main.go

# FROM alpine:3.18

# WORKDIR /app

# COPY --from=builder /app .

# CMD ["/app/main"]



# Stage 1: Build the application
FROM golang:1.22.1-alpine3.18 AS builder

# Create and set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files first
COPY go.mod go.sum ./

# Download the dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o main main.go

# Stage 2: Create the final image
FROM alpine:3.18

# Set the working directory
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/main .

# Set the command to run the application
CMD ["/app/main"]
