$flavorsDir = "$env:APPDATA\yazi\config\flavors"
$scriptDir = $PSScriptRoot

$themes = @(
    "monokai-classic"
    "monokai-pro"
    "monokai-pro-filter-machine"
    "monokai-pro-filter-octagon"
    "monokai-pro-filter-ristretto"
    "monokai-pro-filter-spectrum"
    "monokai-pro-light"
    "monokai-pro-light-filter-sun"
)

New-Item -ItemType Directory -Force -Path $flavorsDir | Out-Null

Write-Host "Copying themes to $flavorsDir..."
foreach ($theme in $themes) {
    Copy-Item -Recurse -Force "$scriptDir\$theme.yazi" "$flavorsDir\"
}
Write-Host "Done."

Write-Host ""
Write-Host "Available themes:"
for ($i = 0; $i -lt $themes.Count; $i++) {
    Write-Host "  $($i + 1). $($themes[$i])"
}

Write-Host ""
$choice = Read-Host "Enter number of theme to enable"

if ($choice -notmatch '^\d+$' -or [int]$choice -lt 1 -or [int]$choice -gt $themes.Count) {
    Write-Error "Invalid selection."
    exit 1
}

$selected = $themes[[int]$choice - 1]

$themeToml = "$env:APPDATA\yazi\config\theme.toml"
@"
[flavor]
dark = "$selected"
"@ | Set-Content -Path $themeToml

Write-Host "Enabled: $selected"
