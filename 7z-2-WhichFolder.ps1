[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Tüm alt klasörleri 7z en hızlı sıkıştırma seviyesiyle sıkıştırır ve klasörü siler.
# hangi klasör işlemde olduğunu gösterir.

Get-ChildItem -Directory | ForEach-Object {
    $folderPath = $_.FullName
    $folderName = $_.Name
    Write-Output "İşleniyor: $folderName"
    & "7z.exe" a -mx=1 "$folderName.7z" -r "$folderPath" | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Sıkıştırma tamamlandı: $folderName. Klasör siliniyor..."
        Remove-Item -Recurse -Force "$folderPath"
    } else {
        Write-Output "Hata oluştu: $folderName"
    }
}
