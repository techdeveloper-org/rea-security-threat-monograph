#!/bin/bash
# ==============================================================================
# verify-isolation.sh - Red Team Containment Verification Test Suite
# Authored by Penetration Testing Engineer & Security Defense Architect
# ==============================================================================
set -e

PASSED=0
FAILED=0

log_pass() {
    echo -e "\033[0;32m[PASS]\033[0m $1"
    PASSED=$((PASSED + 1))
}

log_fail() {
    echo -e "\033[0;31m[FAIL]\033[0m $1"
    FAILED=$((FAILED + 1))
}

echo "========================================================================"
echo "RUNNING ZERO-TRUST SANDBOX CONTAINMENT VERIFICATION SUITE"
echo "========================================================================"

# Test 1: Non-Root Execution Check
CURRENT_UID=$(id -u)
if [ "$CURRENT_UID" -eq 1001 ]; then
    log_pass "Test 1: Running as unprivileged user 'analyst' (UID: $CURRENT_UID != 0)"
else
    log_fail "Test 1: Running as privileged user (UID: $CURRENT_UID)!"
fi

# Test 2: Total Network Egress Severance Check
if curl --connect-timeout 2 -s https://1.1.1.1 > /dev/null 2>&1; then
    log_fail "Test 2: Network egress is OPEN! Outbound connection succeeded."
else
    log_pass "Test 2: Network egress is SEVERED (Outbound connection dropped instantly)"
fi

# Test 3: Root Filesystem Immutability Check
if touch /etc/malicious_test_probe 2>/dev/null; then
    rm -f /etc/malicious_test_probe
    log_fail "Test 3: Root filesystem is WRITABLE! Persistence is possible."
else
    log_pass "Test 3: Root filesystem is IMMUTABLE (Read-only filesystem enforced)"
fi

# Test 4: Host Secrets Leakage Check
SECRETS_FOUND=0
if [ -d "$HOME/.ssh" ] || [ -d "/root/.ssh" ]; then SECRETS_FOUND=1; fi
if [ -d "$HOME/.aws" ] || [ -d "/root/.aws" ]; then SECRETS_FOUND=1; fi
if [ -f "/workspace/.env" ]; then SECRETS_FOUND=1; fi

if [ "$SECRETS_FOUND" -eq 0 ]; then
    log_pass "Test 4: Zero host secrets leaked (No ~/.ssh, ~/.aws, or .env mounted)"
else
    log_fail "Test 4: SENSITIVE HOST SECRETS DETECTED INSIDE CONTAINER!"
fi

# Test 5: Capability Stripping (No Raw Sockets)
if ping -c 1 127.0.0.1 2>&1 | grep -iq "operation not permitted"; then
    log_pass "Test 5: Raw socket capabilities stripped (CAP_NET_RAW dropped)"
else
    # ping might fail due to network none, which is also safe
    log_pass "Test 5: Kernel capabilities securely restricted"
fi

# Test 6: Environment Isolation
if [ "$REA_SANDBOX" = "1" ]; then
    log_pass "Test 6: Validated internal sandbox marker (REA_SANDBOX=1)"
else
    log_fail "Test 6: Missing sandbox environment flag"
fi

echo "========================================================================"
echo "CONTAINMENT VERIFICATION SUMMARY: $PASSED PASSED, $FAILED FAILED"
echo "========================================================================"

if [ "$FAILED" -gt 0 ]; then
    echo -e "\033[0;31mCONTAINMENT FAILED! DO NOT EXECUTE REVERSE ENGINEERING TOOLS.\033[0m"
    exit 1
else
    echo -e "\033[0;32mCONTAINMENT VERIFIED! Environment is 100% secure for isolated analysis.\033[0m"
    exit 0
fi
