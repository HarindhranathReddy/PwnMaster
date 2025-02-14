# ──────────────────────────────────────────────
# 🔥 All-In-One Hacking Tool - Docker Setup 🔥
# ──────────────────────────────────────────────

# Base Image (Using Kali Rolling for Pre-Installed Tools)
FROM kalilinux/kali-rolling AS builder

# Update & Install Required Packages
RUN apt update && apt upgrade -y && \
    apt install -y python3 python3-pip git amass subfinder gobuster wfuzz assetfinder sqlmap nuclei \
    curl wget tor proxychains-ng && \
    pip3 install --no-cache-dir httpx tqdm requests pyyaml openai colorama

# Set Work Directory
WORKDIR /app

# Copy Project Files
COPY . .

# Run Setup Script
RUN chmod +x scripts/setup.sh && ./scripts/setup.sh

# ──────────────────────────────────────────────
# 🌍 Enable Proxy Support (Optional)
# ──────────────────────────────────────────────
ENV PROXY_ENABLED=true
ENV PROXY_LIST=http://127.0.0.1:9050,socks5://127.0.0.1:9150

# Set OpenAI API Key (Use ARG for Build-Time Injection)
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

# ──────────────────────────────────────────────
# 🔥 Entry Point (Run the Scan Automatically)
# ──────────────────────────────────────────────
ENTRYPOINT ["bash", "scripts/run_scan.sh"]
