# Betiğin bulunduğu dizine geçiş yap
Set-Location -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Karakter kodlamasını UTF-8 olarak ayarla
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$folders = Get-ChildItem -Directory
$total = $folders.Count
$count = 0

foreach ($folder in $folders) {
    $count++
    $folderPath = $folder.FullName
    $folderName = $folder.Name

    # İlerleme oranını hesapla
    $percentComplete = [math]::Round(($count / $total) * 100)
    $progressBar = "#" * ($percentComplete / 2) + " " * (50 - ($percentComplete / 2))
    
    # İlerleme çubuğunu ve işlenen klasör adını göster
    Write-Host -NoNewline "`r[$progressBar] $percentComplete% - $folderName işleniyor... "
    
    # Sıkıştırma işlemi
    & "7z.exe" a -mx=1 "$folderName.7z" -r "$folderPath" | Out-Null
    
    # Eğer başarılıysa klasörü sil
    if ($LASTEXITCODE -eq 0) {
        Remove-Item -Recurse -Force "$folderPath"
    }
}

Write-Host "`nTüm klasörler başarıyla sıkıştırıldı ve orijinalleri silindi."

# Ekranın kapanmasını önlemek için bekle
Pause
