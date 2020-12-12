# Delete some cache
$forbiddenList = @(
  "C:",
  "C:\",
  "C:\Program Files",
  "C:\Program Files\",
  "C:\Program Files (x86)",
  "C:\Program Files (x86)\",
  "C:\ProgramData",
  "C:\ProgramData\"
)

Function RemoveItem {
  param ($item)
  if ([string]::IsNullOrWhiteSpace($item)) { return }
  $item = $item.Trim()

  if ($item -In $forbiddenList) {
    "CheckPt: NOT allow to delete $item"
  }
  else {
    if (Test-Path $item) {
      "CheckPt: Removing $item"
      Remove-Item $item -Recurse -ErrorAction SilentlyContinue
    }
  }
}

RemoveItem $env:LOCALAPPDATA\CrashDumps\
RemoveItem $env:LOCALAPPDATA\D3DSCache\
RemoveItem $env:LOCALAPPDATA\Docker\install-log*
RemoveItem $env:LOCALAPPDATA\Docker\log*
RemoveItem $env:LOCALAPPDATA\main.kts.compiled.cache\
RemoveItem $env:LOCALAPPDATA\npm-cache\
RemoveItem $env:LOCALAPPDATA\NuGet\Cache\
RemoveItem $env:LocalAppData\pip\Cache
RemoveItem $env:Temp\