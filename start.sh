#!/bin/sh

# ၁။ Cloudflare Tunnel ကို Background မှာ စမောင်းပါမယ် (သင်ပေးထားတဲ့ Token ကို သုံးထားပါတယ်)
echo "Starting Cloudflare Tunnel..."
cloudflared tunnel --no-autoupdate run --token eyJhIjoiMzcwZTRmM2E4MzVmZWU3Yzk1MzBiYWJlNWYxMzBjZTgiLCJ0IjoiNDRhNzA3NTktMGRiYS00YTdhLTk3OTItMDI0Y2Q1OTYwYzQ3IiwicyI6IlpEbGtZVFptTm1RdE1XRmxaQzAwTWpBNExUaGxPRGt0TUdGaU9EUTRZalUxTVdaaiJ9 &

# ၂။ V2Ray ကို ရှေ့တန်း (Foreground) မှာ ဆက်မောင်းပါမယ်
echo "Starting V2Ray Server..."
v2ray run -config /etc/v2ray/config.json
