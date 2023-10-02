# syntax=docker/dockerfile:1
FROM rust AS builder
WORKDIR /src/
COPY . .

RUN mkdir /artifacts/
# Create cache mount for both the `target` folder
# And a cache mount for the cargo registry
RUN \
    # --mount=type=cache,target=/src/target,rw \
    --mount=type=cache,target=/usr/local/cargo/registry,rw \
    --mount=type=cache,target=${RUST_HOME},rw 
RUN cargo build --release

# Copy all of the executables in the root of the target directory
RUN \
    # --mount=type=cache,target=/src/target,rw \
    find /src/target/release/ \
        -maxdepth 1 \
        -type f -executable \
        -exec cp {} /artifacts/ \;

# This is a lighter image that only contains the artifacts
FROM alpine AS build-artifacts
COPY --from=builder /artifacts/ /artifacts/

# Optimus AKA GardenBot
FROM rust:slim AS optimus
COPY --from=build-artifacts \
    /artifacts/optimus \
    /app/optimus
ENTRYPOINT ["/app/optimus"]