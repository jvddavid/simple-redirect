FROM rust:alpine AS builder
ARG APP_NAME="simple-redirect"

RUN apk update
RUN apk add --no-cache libc6-compat musl-dev

WORKDIR /usr/src/$APP_NAME
COPY . .

RUN cargo build --release

FROM alpine:3.20.2 AS runtime

ARG APP_NAME="simple-redirect"
ENV ROCKET_PORT=80
ENV REDIRECT_URL="https://www.google.com"
COPY --from=builder /usr/src/$APP_NAME/target/release/$APP_NAME /usr/local/bin/myapp

ENTRYPOINT ["/usr/local/bin/myapp"]
