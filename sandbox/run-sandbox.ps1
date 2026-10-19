<#
.SYNOPSIS
    Launches the Zero-Trust REA Hardened Sandbox on Windows.
.DESCRIPTION
    Builds and starts the air-gapped, unprivileged container sandbox.
    Verifies isolation before granting an interactive analysis shell.
#>
param (
    [switch]$VerifyOnly,
    [switch]$Rebuild
)

$ErrorActionPreference = "Stop"

Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host "   ZERO-TRUST REA SECURITY SANDBOX LAUNCHER (WINDOWS POWERSHELL)    " -ForegroundColor Cyan
Write-Host "====================================================================" -ForegroundColor Cyan

# 1. Check Docker Daemon
try {
    $null = docker version
    Write-Host "[+] Docker daemon detected and responsive." -ForegroundColor Green
} catch {
    Write-Host "[!] ERROR: Docker is not running. Please start Docker Desktop first." -ForegroundColor Red
    exit 1
}

$SandboxDir = $PSScriptRoot

# 2. Build Image if needed
$ImageName = "rea-security-sandbox:1.0.0"
$ImageExists = docker images -q $ImageName

if (-not $ImageExists -or $Rebuild) {
    Write-Host "[+] Building hardened sandbox image ($ImageName)..." -ForegroundColor Yellow
    docker compose -f "$SandboxDir\docker-compose.yml" build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] Failed to build sandbox container." -ForegroundColor Red
        exit 1
    }
}

# 3. If VerifyOnly, run verification test suite
if ($VerifyOnly) {
    Write-Host "[+] Executing automated containment verification suite..." -ForegroundColor Yellow
    docker run --rm `
        --network none `
        --cap-drop=ALL `
        --security-opt=no-new-privileges:true `
        --read-only `
        --tmpfs /workspace:rw,size=512m `
        --tmpfs /tmp:rw,size=256m `
        -v "$SandboxDir\verify-isolation.sh:/workspace/verify-isolation.sh:ro" `
        $ImageName bash /workspace/verify-isolation.sh
    exit $LASTEXITCODE
}

# 4. Launch Interactive Sandbox
Write-Host "[+] Launching isolated shell. All network egress is severed." -ForegroundColor Green
Write-Host "[+] Host filesystem is completely protected. Type 'exit' to terminate." -ForegroundColor Green

docker compose -f "$SandboxDir\docker-compose.yml" run --rm rea-sandbox
