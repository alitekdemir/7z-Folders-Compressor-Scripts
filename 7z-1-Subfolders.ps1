[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Tüm alt klasörleri 7z en hızlı sıkıştırma seviyesiyle sıkıştırır ve klasörü siler.

Get-ChildItem -Directory | ForEach-Object {
    $folderPath = $_.FullName
    $folderName = $_.Name
    & "7z.exe" a -mx=1 "$folderName.7z" -r "$folderPath" | Out-Null
    if ($LASTEXITCODE -eq 0) { Remove-Item -Recurse -Force "$folderPath" }
}