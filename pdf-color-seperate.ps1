param([string]$name = '*') 
$filename = $name -split '\.' | select -First 1

$curr_path = Get-Location
Start-Process -FilePath "python" -ArgumentList "C:\scripts\pdf-color-seperate.py",$curr_path, $filename -NoNewWindow