$DOWNLOADS_DIR = Get-Location  #"C:\Users\karth\Downloads"

$data = @{
    "img" = @{
        "path" = "C:\Users\karth\Pictures"
        "extension" = @(".jpg", ".jpeg", ".jfif", ".pjpeg", ".pjp", ".png", ".gif", ".webp", ".svg", ".apng", ".avif")
    }
    "audio" = @{
        "path" = "C:\Users\karth\Music"
        "extension" = @(".3ga", ".aac", ".ac3", ".aif", ".aiff", ".alac", ".amr", ".ape", ".au", ".dss", ".flac", ".flv", ".m4a", ".m4b", ".m4p", ".mp3", ".mpga", ".ogg", ".oga", ".mogg", ".opus", ".qcp", ".tta", ".voc", ".wav", ".wma", ".wv")
    }
    "video" = @{
        "path" = "C:\Users\karth\Videos"
        "extension" = @(".webm", ".MTS", ".M2TS", ".TS", ".mov", ".mp4", ".m4p", ".m4v", ".mxf")
    }
}

$extension_map = @{}
foreach ($type_data in $data.Values) {
    foreach ($extension in $type_data["extension"]) {
        $extension_map[$extension] = $type_data["path"]
    }
}

$extension_map["Screenshot"] = "C:\Users\karth\Pictures\Screenshots"

foreach ($path in (Get-ChildItem -Path $DOWNLOADS_DIR -File)) {
    $extension = $path.Extension
    if ($extension -eq ".png" -and $path.BaseName -like "Screenshot*") {
        $extension = $extension_map["Screenshot"]
    }
    
    $base_path = $extension_map[$extension]

    if ($base_path -ne $null) {
        Move-Item -Path $path.FullName -Destination "$base_path\$($path.Name)"
    }
}

Write-Host "`n" + "*" * 40 + " COMPLETED " + "*" * 40 + "`n"
