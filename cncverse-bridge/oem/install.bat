@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$release = Invoke-RestMethod 'https://api.github.com/repos/NivinCNC/CNCVerse-Bridge/releases/latest'; ^
   $asset = $release.assets | Where-Object { $_.name -match '\.msi$' } | Select-Object -First 1; ^
   Invoke-WebRequest $asset.browser_download_url -OutFile 'C:\OEM\cncverse.msi'"

msiexec /i "C:\OEM\cncverse.msi" /qn /norestart