FROM alpine:latest

# Install dependencies including Python3
RUN apk add --no-cache ca-certificates bash curl unzip python3

# Download and install V2Ray
RUN mkdir /v2ray && \
    curl -L "https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip" -o /v2ray.zip && \
    unzip /v2ray.zip -d /v2ray && \
    chmod +x /v2ray/v2ray && \
    rm /v2ray.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
