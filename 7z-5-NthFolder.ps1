# Karakter kodlamasını UTF-8 olarak ayarla
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Tüm alt klasörleri 7z en hızlı sıkıştırma seviyesiyle sıkıştırır ve klasörü siler.
# X/YY : klasör adı formatında işlem sırasını gösterir.

$folders = Get-ChildItem -Directory
$total = $folders.Count
$count = 0

foreach ($folder in $folders) {
    $count++
    $folderPath = $folder.FullName
    $folderName = $folder.Name

    # X/YY : klasör adı formatında görüntüle
    Write-Host "`r$count/$total : $folderName işleniyor..."

    # Sıkıştırma işlemi
    & "7z.exe" a -mx=1 "$folderName.7z" -r "$folderPath" | Out-Null
    
    # Eğer başarılıysa klasörü sil
    if ($LASTEXITCODE -eq 0) {
        Remove-Item -Recurse -Force "$folderPath"
    }
}

Write-Host "`nTüm klasörler başarıyla sıkıştırıldı ve orijinalleri silindi."