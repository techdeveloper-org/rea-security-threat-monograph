#!/usr/bin/env bash
# ==============================================================================
# run-sandbox.sh - Zero-Trust REA Hardened Sandbox Launcher (Linux/macOS)
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="rea-security-sandbox:1.0.0"

echo "===================================================================="
echo "   ZERO-TRUST REA SECURITY SANDBOX LAUNCHER (POSIX BASH)            "
echo "===================================================================="

# 1. Verify Docker Daemon
if ! docker version > /dev/null 2>&1; then
    echo -e "\033[0;31m[!] ERROR: Docker is not running or current user lacks permissions.\033[0m"
    exit 1
fi
echo -e "\033[0;32m[+] Docker daemon verified.\033[0m"

# 2. Build image if absent
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo -e "\033[0;33m[+] Building hardened sandbox image ($IMAGE_NAME)...\033[0m"
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" build
fi

# 3. Handle --verify flag
if [ "$1" = "--verify" ]; then
    echo -e "\033[0;33m[+] Running automated containment verification suite...\033[0m"
    docker run --rm \
        --network none \
        --cap-drop=ALL \
        --security-opt=no-new-privileges:true \
        --read-only \
        --tmpfs /workspace:rw,size=512m \
        --tmpfs /tmp:rw,size=256m \
        -v "$SCRIPT_DIR/verify-isolation.sh:/workspace/verify-isolation.sh:ro" \
        "$IMAGE_NAME" bash /workspace/verify-isolation.sh
    exit $?
fi

# 4. Interactive Contained Shell
echo -e "\033[0;32m[+] Starting isolated shell. Outbound egress is completely severed.\033[0m"
docker compose -f "$SCRIPT_DIR/docker-compose.yml" run --rm rea-sandbox
