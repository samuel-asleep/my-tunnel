#!/usr/bin/env bash

# Set defaults
UUID=${UUID:-"samuel"}
PORT=${PORT:-8080}

# 1. Start a simple Python HTTP server in the background on the same port
# This responds to Koyeb's health checks and external pings
echo "Starting ping responder..."
python3 -m http.server $PORT & 

# 2. Create V2Ray config
cat << EOF > /v2ray/config.json
{
    "inbounds": [{
        "port": $PORT, 
        "protocol": "vless",
        "settings": {
            "clients": [{"id": "$UUID"}],
            "decryption": "none"
        },
        "streamSettings": {
            "network": "ws",
            "wsSettings": {
                "path": "/vless" 
            }
        }
    }],
    "outbounds": [{"protocol": "freedom"}]
}
EOF

# 3. Start V2Ray
echo "Starting V2Ray..."
/v2ray/v2ray run -config /v2ray/config.json
