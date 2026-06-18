FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# ၁။ လိုအပ်တဲ့ Base Packages တွေ အကုန်လုံးကို အမှားကင်းအောင် တစ်ခါတည်း သွင်းခြင်း
RUN apt update -y && apt install --no-install-recommends -y \
    websockify sudo xterm init systemd snapd vim net-tools curl wget git tzdata screen openssh-server sshpass \
    && apt clean && rm -rf /var/lib/apt/lists/*

# ၂။ SSH Config ပြင်ဆင်ခြင်း၊ အသုံးပြုသူ (User) ဆောက်ခြင်းနှင့် Password ပေးခြင်း
RUN rm -rf /etc/ssh/sshd_config && cd /etc/ssh && \
    wget https://github.com/githubaunglaymyanmar/fordownload/raw/main/ssh/sshd_config && \
    useradd -m aunglay && adduser aunglay sudo && \
    echo 'aunglay:aunglay' | chpasswd && \
    sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd && \
    echo "aunglay ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "root:aunglay" | chpasswd

# ၃။ vpn script ကို ဒေါင်းလုဒ်ဆွဲပြီး /usr/local/bin/vpn ထဲမှာ သိမ်းဆည်းခြင်း
RUN wget -O /usr/local/bin/vpn https://github.com/ggncvvv/Railwayv2ray/raw/refs/heads/main/vpn && \
    chmod +x /usr/local/bin/vpn

# Port များ ဖွင့်ပေးခြင်း
EXPOSE 22
EXPOSE 6080

# ၄။ Container စတာနဲ့ vpn script ကို တိုက်ရိုက် run ခိုင်းခြင်း
CMD ["/bin/bash", "/usr/local/bin/vpn"]





