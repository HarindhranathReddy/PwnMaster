#!/bin/bash

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "[ERROR] This script must be run as root. Use sudo!"
    exit 1
fi

# Update package lists
echo "[INFO] Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

# Install necessary dependencies
echo "[INFO] Installing required dependencies..."
sudo apt install -y python3 python3-pip golang git curl wget

# Define tool installation functions
install_sqlmap() {
    echo "[INFO] Installing SQLMap..."
    sudo apt install -y sqlmap
}

install_nosqlmap() {
    echo "[INFO] Installing NoSQLMap..."
    git clone https://github.com/codingo/NoSQLMap.git /opt/nosqlmap
    cd /opt/nosqlmap && pip3 install -r requirements.txt
}

install_xsstrike() {
    echo "[INFO] Installing XSStrike..."
    git clone https://github.com/s0md3v/XSStrike.git /opt/xsstrike
    cd /opt/xsstrike && pip3 install -r requirements.txt
}

install_dalfox() {
    echo "[INFO] Installing Dalfox..."
    go install github.com/hahwul/dalfox/v2@latest
    export PATH=$PATH:$(go env GOPATH)/bin
}

install_oralyzer() {
    echo "[INFO] Installing Oralyzer..."
    git clone https://github.com/r0075h3ll/Oralyzer.git /opt/oralyzer
    cd /opt/oralyzer && pip3 install -r requirements.txt
}

install_ssrfmap() {
    echo "[INFO] Installing SSRFmap..."
    git clone https://github.com/swisskyrepo/SSRFmap.git /opt/ssrfmap
    cd /opt/ssrfmap && pip3 install -r requirements.txt
}

install_gopherus() {
    echo "[INFO] Installing Gopherus..."
    git clone https://github.com/tarunkant/Gopherus.git /opt/gopherus
}

install_lfisuite() {
    echo "[INFO] Installing LFISuite..."
    git clone https://github.com/D35m0nd142/LFISuite.git /opt/lfisuite
}

install_kadabra() {
    echo "[INFO] Installing Kadabra..."
    git clone https://github.com/D35m0nd142/Kadabra.git /opt/kadabra
}

install_metasploit() {
    echo "[INFO] Installing Metasploit..."
    sudo apt install -y metasploit-framework
}

install_csrfpoc() {
    echo "[INFO] Installing CSRFPoCGenerator..."
    git clone https://github.com/SpiderLabs/CSRFPoCGenerator.git /opt/csrfpoc
}

install_burp_suite() {
    echo "[INFO] Burp Suite needs manual installation from: https://portswigger.net/burp"
}

install_h2c_smuggler() {
    echo "[INFO] Installing H2C Smuggler..."
    git clone https://github.com/BishopFox/h2cSmuggler.git /opt/h2csmuggler
}

install_autorize() {
    echo "[INFO] Installing Autorize (Burp Extension)..."
    echo "[INFO] Install via Burp Suite Extension Store"
}

install_arjun() {
    echo "[INFO] Installing Arjun..."
    git clone https://github.com/s0md3v/Arjun.git /opt/arjun
    cd /opt/arjun && pip3 install -r requirements.txt
}

install_trufflehog() {
    echo "[INFO] Installing TruffleHog..."
    pip3 install truffleHog
}

install_gitleaks() {
    echo "[INFO] Installing GitLeaks..."
    wget https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64 -O /usr/local/bin/gitleaks
    chmod +x /usr/local/bin/gitleaks
}

install_nuclei() {
    echo "[INFO] Installing Nuclei..."
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
    export PATH=$PATH:$(go env GOPATH)/bin
}

# Install all tools
echo "[INFO] Installing all tools..."
install_sqlmap
install_nosqlmap
install_xsstrike
install_dalfox
install_oralyzer
install_ssrfmap
install_gopherus
install_lfisuite
install_kadabra
install_metasploit
install_csrfpoc
install_burp_suite
install_h2c_smuggler
install_autorize
install_arjun
install_trufflehog
install_gitleaks
install_nuclei

echo "[INFO] Installation complete! All tools are installed successfully."
