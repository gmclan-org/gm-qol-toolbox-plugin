# GM QoL Toolbox - uninstall the plugin from GameMaker Beta
# Run: powershell -ExecutionPolicy Bypass -File uninstall-beta.ps1

$ErrorActionPreference = "Stop"

$pluginName   = "GmclanToolboxPlugin"
$author       = "gmclan.org"
$pluginsRoot  = "C:\ProgramData\GameMakerStudio2-Beta\Plugins"
$targetDir    = Join-Path $pluginsRoot $pluginName
$manifestPath = Join-Path $pluginsRoot "plugins.json"

Write-Host "=== Uninstalling $pluginName (Beta) ===" -ForegroundColor Cyan

# 1. Remove the plugin folder
if (Test-Path $targetDir) {
    Remove-Item -Recurse -Force $targetDir
    Write-Host "Removed $targetDir" -ForegroundColor Green
} else {
    Write-Host "Folder $targetDir does not exist - skipping." -ForegroundColor Yellow
}

# 2. Remove entry from plugins.json
if (Test-Path $manifestPath) {
    # GMPM (GameMaker's package manager) writes plugins.json with trailing
    # commas (same JSON5-ish style as .yy/.yyp), which ConvertFrom-Json
    # rejects outright - strip them before parsing.
    $manifestRaw = (Get-Content $manifestPath -Raw) -replace ',(\s*[}\]])', '$1'
    $json = $manifestRaw | ConvertFrom-Json
    $filtered = @($json.Plugins) | Where-Object { -not ($_.Name -eq $pluginName -and $_.Author -eq $author) }
    $json.Plugins = @($filtered)
    # ConvertTo-Json via the pipeline unwraps a single-element (or empty)
    # array into a bare object/nothing, corrupting plugins.json - pass
    # -InputObject instead to keep the array intact.
    $out = ConvertTo-Json -InputObject $json -Depth 5
    [System.IO.File]::WriteAllText($manifestPath, $out, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Removed entry from plugins.json" -ForegroundColor Green
}

Write-Host ""
Write-Host "DONE. Plugin $pluginName uninstalled from GameMaker Beta." -ForegroundColor Cyan
