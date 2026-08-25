# GM QoL Toolbox - plugin installer for GameMaker Beta
# Run: powershell -ExecutionPolicy Bypass -File install-beta.ps1

$ErrorActionPreference = "Stop"

$pluginName   = "GmclanToolboxPlugin"
$author       = "gmclan.org"
$pluginsRoot  = "C:\ProgramData\GameMakerStudio2-Beta\Plugins"
$targetDir    = Join-Path $pluginsRoot $pluginName
$manifestPath = Join-Path $pluginsRoot "plugins.json"
$sourceDir    = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "=== $pluginName installer (Beta) ===" -ForegroundColor Cyan

# 1. Is GameMaker Beta installed?
if (-not (Test-Path $pluginsRoot)) {
    Write-Host "ERROR: $pluginsRoot not found" -ForegroundColor Red
    Write-Host "This installer requires GameMaker Beta. Install it and try again."
    exit 1
}

# 2. GameMaker Beta must not be running
$gmProcess = Get-Process -Name "GameMaker-Beta" -ErrorAction SilentlyContinue
if ($gmProcess) {
    Write-Host "ERROR: GameMaker Beta is running. Close it and run the installer again." -ForegroundColor Red
    exit 1
}

# 3. Check for required files
foreach ($file in @("$pluginName.dll", "$pluginName.gmplugin")) {
    if (-not (Test-Path (Join-Path $sourceDir $file))) {
        Write-Host "ERROR: Missing file $file next to the installer." -ForegroundColor Red
        exit 1
    }
}

# 3b. Version - read from the DLL's own metadata (FileVersion, set
# automatically by the SDK from <Version> in the .csproj), not from a
# separate constant here - see install.ps1 for the full rationale.
$dllPath = Join-Path $sourceDir "$pluginName.dll"
$fileVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($dllPath).FileVersion
$version = ($fileVersion -split '\.')[0..2] -join '.'
Write-Host "Version read from $pluginName.dll: $version" -ForegroundColor Cyan

# 4. Copy files
New-Item -ItemType Directory -Force $targetDir | Out-Null
Copy-Item (Join-Path $sourceDir "$pluginName.dll")      $targetDir -Force
Copy-Item (Join-Path $sourceDir "$pluginName.gmplugin") $targetDir -Force
Write-Host "Copied files to $targetDir" -ForegroundColor Green

# 5. Register in plugins.json
$entry = [ordered]@{
    '$PluginToLoad' = "v1"
    'Author'        = $author
    'Name'          = $pluginName
    'Version'       = $version
}

if (Test-Path $manifestPath) {
    # GMPM (GameMaker's package manager) writes plugins.json with trailing
    # commas (same JSON5-ish style as .yy/.yyp), which ConvertFrom-Json
    # rejects outright - strip them before parsing.
    $manifestRaw = (Get-Content $manifestPath -Raw) -replace ',(\s*[}\]])', '$1'
    $json = $manifestRaw | ConvertFrom-Json
    $existing = @($json.Plugins) | Where-Object { $_.Name -eq $pluginName -and $_.Author -eq $author }
    if ($existing) {
        if ($existing.Version -ne $version) {
            $existing.Version = $version
            $out = ConvertTo-Json -InputObject $json -Depth 5
            [System.IO.File]::WriteAllText($manifestPath, $out, (New-Object System.Text.UTF8Encoding($false)))
            Write-Host "Updated version in plugins.json to $version" -ForegroundColor Green
        } else {
            Write-Host "Entry already exists in plugins.json - no changes." -ForegroundColor Yellow
        }
    } else {
        $json.Plugins = @($json.Plugins) + @([pscustomobject]$entry)
        # ConvertTo-Json via the pipeline unwraps a single-element array into
        # a bare object, corrupting plugins.json when only one plugin is
        # registered - pass -InputObject instead to keep the array intact.
        $out = ConvertTo-Json -InputObject $json -Depth 5
        [System.IO.File]::WriteAllText($manifestPath, $out, (New-Object System.Text.UTF8Encoding($false)))
        Write-Host "Added entry to plugins.json" -ForegroundColor Green
    }
} else {
    $manifest = [ordered]@{
        '$PluginLoadCollection' = "v1"
        'Plugins'               = @([pscustomobject]$entry)
    }
    $out = ConvertTo-Json -InputObject ([pscustomobject]$manifest) -Depth 5
    [System.IO.File]::WriteAllText($manifestPath, $out, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Created plugins.json with the plugin entry" -ForegroundColor Green
}

Write-Host ""
Write-Host "DONE. Launch GameMaker Beta - the menu bar will show 'Plugins > Check Object Usage'." -ForegroundColor Cyan
