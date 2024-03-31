# Start-Process -FilePath "python" -ArgumentList "-m", "http.server" -NoNewWindow  ##comment

$curr_path = Get-Location
Start-Process -FilePath "python" -ArgumentList "C:\scripts\serve.py",$curr_path -NoNewWindow