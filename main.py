import os
import asyncio
import yaml
import argparse
import logging
import httpx
from colorama import Fore, Style, init
from modules.recon import find_subdomains
from modules.scanning import find_live_urls
from modules.exploitation import run_exploit
from modules.openai_payload_generator import generate_payload
from modules.utils import print_status

# Initialize color output
init(autoreset=True)

# Load Configuration
CONFIG_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), "../config.yaml"))
try:
    with open(CONFIG_PATH, "r") as f:
        config = yaml.safe_load(f)
except FileNotFoundError:
    print_status("❌ [ERROR] config.yaml not found! Ensure the file exists in the root directory.", "error")
    exit(1)

# Extract settings
OPENAI_API_KEY = config.get("openai_api_key", "")
PROXY_ENABLED = config.get("proxy_settings", {}).get("enable_proxy", False)
VERBOSE = config.get("verbose_mode", True)

# Argument Parser
parser = argparse.ArgumentParser(description="All-In-One Hacking Tool")
parser.add_argument("target", help="Target domain for the scan")
parser.add_argument("--no-exploit", action="store_true", help="Run scan without exploitation phase")
args = parser.parse_args()

# Setup logging
LOG_FILE = os.path.abspath(os.path.join(os.path.dirname(__file__), "../logs/tool.log"))
logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Start the scan
print_status(f"🚀 [INFO] Starting scan for: {args.target}", "start")

# Step 1: Find Subdomains (Async)
async def async_recon():
    print_status("🔍 [INFO] Enumerating subdomains...", "info")
    subs = await find_subdomains(args.target)
    if not subs:
        print_status("⚠ [WARNING] No subdomains found!", "warning")
    return subs

# Step 2: Find Live URLs
def find_live_urls(target):
    print_status(f"🌐 [INFO] Probing live URLs for {target}...", "info")
    # Future: Add probing logic

# Step 3: Fetch & Filter URLs
def fetch_urls():
    print_status("📥 [INFO] Fetching URLs from sources...", "info")
    # Future: Integrate tools like `gauplus`, `katana`, `waybackurls`

# Step 4: Exploit (AI-Generated Payloads + Standard Attacks)
def exploit_target():
    if args.no_exploit:
        print_status("⏭  [INFO] Exploitation phase skipped!", "warning")
        return
    
    print_status("💥 [INFO] Running exploitation phase...", "fire")

    # Select an attack (e.g., SQLi, XSS)
    vuln_type = "SQL Injection"  # Example, can be dynamic
    payload = generate_payload(vuln_type)  # AI-powered payload
    print_status(f"🧠 [INFO] AI-Generated Payload: {payload}", "debug")

    run_exploit(args.target, payload)

# Step 5: Generate AI Report (Optional)
def generate_ai_report():
    if OPENAI_API_KEY:
        print_status("📑 [INFO] Generating AI-Powered Security Report...", "info")
        # Future: AI-based auto-reporting

# Run tasks concurrently
async def main():
    await async_recon()  
    find_live_urls(args.target)  # ✅ FIXED: Calls the correct function
    fetch_urls()
    exploit_target()
    generate_ai_report()
    print_status("🏁 [INFO] Scan Completed!", "end")

# Execute script
if __name__ == "__main__":
    asyncio.run(main())
