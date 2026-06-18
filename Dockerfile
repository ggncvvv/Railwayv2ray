# Step 1: V2Ray ရဲ့ ပုံမှန် Base Image ကို ယူပါမယ်
FROM v2fly/v2fly-core:v4.45.2

# Step 2: Cloudflare Tunnel (cloudflared) ကို ဒေါင်းလုဒ်ဆွဲပြီး သွင်းပါမယ်
# (alpine base ဖြစ်တဲ့အတွက် wget နဲ့ libc compatibility အတွက် ထည့်သွင်းထားပါတယ်)
RUN apk add --no-cache libc6-compat wget ca-certificates && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Step 3: V2Ray ရဲ့ Configuration ဖိုင်ကို ထည့်သွင်းခြင်း
RUN mkdir -p /etc/v2ray && \
    echo '{\
  "inbounds": [{\
    "port": 4444,\
    "protocol": "vmess",\
    "settings": {\
      "clients": [{\
        "id": "11111111-2222-3333-4444-555555555555",\
        "alterId": 0\
      }]\
    },\
    "streamSettings": {\
      "network": "ws",\
      "wsSettings": {\
        "path": "/v2ray"\
      }\
    }\
  }],\
  "outbounds": [{ \
    "protocol": "freedom",\
    "settings": {}\
  }]\
}' > /etc/v2ray/config.json

# Step 4: စောစောက ဆောက်ခဲ့တဲ့ start.sh ကို Docker ထဲ ထည့်ပြီး Run ခွင့် ပေးလိုက်တာပါ
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Port 4444 ကို ဖွင့်ထားပေးခြင်း
EXPOSE 4444

# Container စတာနဲ့ start.sh ကို ပတ်ခိုင်းလိုက်တာပါ
CMD ["/start.sh"]
