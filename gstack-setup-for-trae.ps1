# gstack Skills Setup Script for Trae
# Run this script to copy SKILL.md files to .trae/skills

$sourceBase = "d:\DFX\Code\一人公司\gstack-main - 副本\gstack-main"
$targetBase = "d:\DFX\Code\一人公司\.trae\skills"

$mappings = @{
    "autoplan"                = "gstack-autoplan"
    "browse"                  = "gstack-browse"
    "canary"                  = "gstack-canary"
    "careful"                 = "gstack-careful"
    "codex"                   = "gstack"
    "cso"                     = "gstack-cso"
    "design-consultation"     = "gstack-design-consultation"
    "design-review"           = "gstack-design-review"
    "document-release"        = "gstack-document-release"
    "freeze"                  = "gstack-freeze"
    "guard"                   = "gstack-guard"
    "gstack-upgrade"          = "gstack-upgrade"
    "investigate"             = "gstack-investigate"
    "land-and-deploy"         = "gstack-land-and-deploy"
    "office-hours"            = "gstack-office-hours"
    "plan-ceo-review"         = "gstack-plan-ceo-review"
    "plan-design-review"       = "gstack-plan-design-review"
    "plan-eng-review"         = "gstack-plan-eng-review"
    "qa"                      = "gstack-qa"
    "qa-only"                 = "gstack-qa-only"
    "retro"                   = "gstack-retro"
    "review"                  = "gstack-review"
    "setup-browser-cookies"    = "gstack-setup-browser-cookies"
    "setup-deploy"            = "gstack-setup-deploy"
    "ship"                    = "gstack-ship"
    "unfreeze"                = "gstack-unfreeze"
}

Write-Host "gstack Skills Setup for Trae" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan
Write-Host ""

$success = 0
$failed = 0

foreach ($source in $mappings.Keys) {
    $target = $mappings[$source]
    $sourceFile = Join-Path $sourceBase $source "SKILL.md"
    $targetDir = Join-Path $targetBase $target
    $targetFile = Join-Path $targetDir "SKILL.md"

    if (Test-Path $sourceFile) {
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        Copy-Item -Path $sourceFile -Destination $targetFile -Force
        Write-Host "[OK] $source -> $target" -ForegroundColor Green
        $success++
    } else {
        Write-Host "[SKIP] $source -> $target (source not found)" -ForegroundColor Yellow
        $failed++
    }
}

Write-Host ""
Write-Host "==============================" -ForegroundColor Cyan
Write-Host "Completed: $success copied, $failed skipped" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Yellow" })
Write-Host ""
Write-Host "Verifying installation..." -ForegroundColor Cyan

$verificationFailed = 0
foreach ($target in $mappings.Values | Sort-Object -Unique) {
    $targetFile = Join-Path $targetBase $target "SKILL.md"
    if (Test-Path $targetFile) {
        Write-Host "[OK] $target/SKILL.md exists" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $target/SKILL.md missing!" -ForegroundColor Red
        $verificationFailed++
    }
}

Write-Host ""
if ($verificationFailed -eq 0) {
    Write-Host "All skills installed successfully!" -ForegroundColor Green
} else {
    Write-Host "$verificationFailed skill(s) failed verification." -ForegroundColor Red
}
