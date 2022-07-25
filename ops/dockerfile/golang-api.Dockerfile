# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM golang:1.18 AS builder

ARG CI_COMMIT_TAG
# `skaffold debug` sets SKAFFOLD_GO_GCFLAGS to disable compiler optimizations
ARG SKAFFOLD_GO_GCFLAGS
ARG TARGETOS TARGETARCH

# Define GOTRACEBACK to mark this container as using the Go language runtime
# for `skaffold debug` (https://skaffold.dev/docs/workflows/debug/).
ENV GOTRACEBACK=all

WORKDIR /go/github.com/batazor/remote-debug

# Load dependencies
COPY go.mod go.sum ./
RUN go mod download

# COPY the source code as the last step
COPY . .

# Build project
RUN --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go/pkg \
  CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
  go build \
  -a \
  -gcflags="${SKAFFOLD_GO_GCFLAGS}" \
  -installsuffix cgo \
  -trimpath \
  -o app .

ENTRYPOINT ["go", "run", "-mod", "vendor", "main.go"]

FROM --platform=$BUILDPLATFORM golang:1.18 AS debugger

EXPOSE 7070 40000

# Build Delve
RUN go install github.com/go-delve/delve/cmd/dlv@latest

WORKDIR /
COPY --from=builder /go/github.com/batazor/remote-debug /go/github.com/batazor/remote-debug

CMD ["dlv", "--listen=:40000", "--headless=true", "--api-version=2", "--accept-multiclient", "debug", "/go/github.com/batazor/remote-debug"]

FROM alpine:3.6

EXPOSE 7070

WORKDIR /app/
CMD ["./app"]
COPY --from=builder /go/github.com/batazor/remote-debug/app /app
