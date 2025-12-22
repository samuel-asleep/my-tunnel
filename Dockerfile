FROM alpine:latest

# Install dependencies and V2Ray
RUN apk add --no-cache ca-certificates bash curl
RUN curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip /v2ray.zip -d /v2ray \
    && chmod +x /v2ray/v2ray \
    && rm /v2ray.zip

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Koyeb uses dynamic ports, so we will set this in the script
ENTRYPOINT ["/entrypoint.sh"]
