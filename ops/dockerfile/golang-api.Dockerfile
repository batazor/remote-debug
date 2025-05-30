# syntax=docker/dockerfile:1.16

FROM --platform=$BUILDPLATFORM golang:1.24 AS builder

ARG CI_COMMIT_TAG
# `skaffold debug` sets SKAFFOLD_GO_GCFLAGS to disable compiler optimizations
ARG SKAFFOLD_GO_GCFLAGS
ARG TARGETOS TARGETARCH

WORKDIR /code

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
  -o /app .

ENTRYPOINT ["go", "run", "-mod", "vendor", "main.go"]

FROM alpine:3.21

# Define GOTRACEBACK to mark this container as using the Go language runtime
# for `skaffold debug` (https://skaffold.dev/docs/workflows/debug/).
ENV GOTRACEBACK=single

WORKDIR /app
CMD ["./app"]
COPY --from=builder /app .
