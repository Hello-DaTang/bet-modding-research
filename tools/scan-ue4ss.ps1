param(
    [string]$GameRoot = "D:\Program Files (x86)\Steam\steamapps\common\Backrooms_Escape_Together",
    [string]$OutputDir = ".\captures\initial-scan"
)

$ErrorActionPreference = "Stop"

$Win64 = Join-Path $GameRoot "BET\Binaries\Win64"
$UE4SS = Join-Path $Win64 "ue4ss"
$Log = Join-Path $UE4SS "UE4SS.log"
$Dump = Join-Path $UE4SS "UE4SS_ObjectDump.txt"

if (-not (Test-Path $Log)) {
    throw "UE4SS.log not found: $Log"
}

if (-not (Test-Path $Dump)) {
    throw "UE4SS_ObjectDump.txt not found: $Dump"
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$EnvironmentFile = Join-Path $OutputDir "environment.txt"
$LogTailFile = Join-Path $OutputDir "ue4ss-log-tail.txt"
$LogSignalsFile = Join-Path $OutputDir "ue4ss-log-signals.txt"
$DumpHitsFile = Join-Path $OutputDir "object-dump-hits.txt"

@(
    "Scan time: $(Get-Date -Format o)"
    "GameRoot: $GameRoot"
    "Win64: $Win64"
    "UE4SS: $UE4SS"
    "Game binary: $(Join-Path $Win64 'BETGameSteam-Win64-Shipping.exe')"
    "UE4SS.log size: $((Get-Item $Log).Length) bytes"
    "UE4SS_ObjectDump.txt size: $((Get-Item $Dump).Length) bytes"
) | Set-Content -Encoding UTF8 $EnvironmentFile

# Keep a bounded tail for startup/shutdown state and recent errors.
Get-Content $Log -Tail 300 | Set-Content -Encoding UTF8 $LogTailFile

# Signals that usually tell us whether the loader, signatures, mappings and Lua layer initialized.
$logPatterns = @(
    'error',
    'fatal',
    'failed',
    'exception',
    'signature',
    'mapping',
    'usmap',
    'lua',
    'mod',
    'hook',
    'initialized',
    'initializ',
    'loaded',
    'loading'
)

Select-String -Path $Log -Pattern $logPatterns -SimpleMatch -CaseSensitive:$false |
    Select-Object -First 500 |
    ForEach-Object { "{0}:{1}: {2}" -f $_.Filename, $_.LineNumber, $_.Line.Trim() } |
    Set-Content -Encoding UTF8 $LogSignalsFile

# First-pass class/function vocabulary. We intentionally keep this broad and read-only.
$dumpPatterns = @(
    'PlayerController',
    'PlayerState',
    'Character',
    'GameMode',
    'GameState',
    'Inventory',
    'Item',
    'Pickup',
    'Interact',
    'Stamina',
    'Health',
    'Damage',
    'Death',
    'Revive',
    'Respawn',
    'Entity',
    'AIController',
    'BehaviorTree',
    'Procedural',
    'Generator',
    'Seed',
    'Lobby',
    'Session',
    'Server_',
    'Server',
    'Client_',
    'Multicast',
    'OnRep_',
    'RepNotify',
    'Replicated'
)

$allHits = foreach ($pattern in $dumpPatterns) {
    $hits = Select-String -Path $Dump -Pattern $pattern -SimpleMatch -CaseSensitive:$false |
        Select-Object -First 80

    "===== PATTERN: $pattern ====="
    if ($hits) {
        foreach ($hit in $hits) {
            "{0}:{1}: {2}" -f $hit.Filename, $hit.LineNumber, $hit.Line.Trim()
        }
    } else {
        "<NO MATCH>"
    }
    ""
}

$allHits | Set-Content -Encoding UTF8 $DumpHitsFile

Write-Host "Initial UE4SS scan complete."
Write-Host "Output: $((Resolve-Path $OutputDir).Path)"
Write-Host ""
Write-Host "Files:"
Write-Host "  $EnvironmentFile"
Write-Host "  $LogTailFile"
Write-Host "  $LogSignalsFile"
Write-Host "  $DumpHitsFile"
Write-Host ""
Write-Host "This script is read-only with respect to the game and UE4SS files."
