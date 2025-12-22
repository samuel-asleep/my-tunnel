#!/usr/bin/env bash

# Set defaults
UUID=${UUID:-"de04add9-5c68-8bab-950c-08cd5320df18"}
PORT=${PORT:-8080}

# 1. Start Python on a PRIVATE port (8000)
# This will not conflict with the main port 8080
echo "Starting internal web server on port 8000..."
python3 -m http.server 8000 & 

# 2. Create V2Ray config with "Fallback"
cat << EOF > /v2ray/config.json
{
    "inbounds": [{
        "port": $PORT,
        "protocol": "vless",
        "settings": {
            "clients": [{"id": "$UUID"}],
            "decryption": "none",
            "fallbacks": [{
                "dest": 8000 
            }]
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
echo "Starting V2Ray on public port $PORT..."
/v2ray/v2ray run -config /v2ray/config.json
