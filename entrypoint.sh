#!/usr/bin/env bash

# Set default UUID if not provided via Koyeb environment variables
UUID=${UUID:-"de04add9-5c68-8bab-950c-08cd5320df18"}
PORT=${PORT:-8080}

# Create V2Ray config file
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

# Start V2Ray
/v2ray/v2ray run -config /v2ray/config.json
 
