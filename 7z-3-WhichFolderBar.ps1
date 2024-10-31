[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Tüm alt klasörleri 7z en hızlı sıkıştırma seviyesiyle sıkıştırır ve klasörü siler.
# ilerleme çubuğu gösterir.

$folders = Get-ChildItem -Directory
$total = $folders.Count
$count = 0

foreach ($folder in $folders) {
    $count++
    $folderPath = $folder.FullName
    $folderName = $folder.Name
    Write-Progress -Activity "Sıkıştırılıyor..." -Status "$folderName işleniyor" -PercentComplete (($count / $total) * 100)

    & "7z.exe" a -mx=1 "$folderName.7z" -r "$folderPath" | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Remove-Item -Recurse -Force "$folderPath"
    }
}

Write-Host "Tüm klasörler başarıyla sıkıştırıldı ve orijinalleri silindi."
