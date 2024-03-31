param([string]$name = '*') 
$filename = $name -split '\.' | select -First 1

# Get invocation path
$curr_path = Get-Location
# Create a word object
$word_app = New-Object -ComObject Word.Application
# Get all objects of type .ppt? in $curr_path and its subfolders
Get-ChildItem -Path $curr_path -Recurse -Filter ($filename + ".doc?") | ForEach-Object {
    Write-Host "Processing" $_.FullName "..."
    # Open it in word
    $document = $word_app.Documents.Open($_.FullName)
    # Create a name for the PDF document; they are stored in the invocation folder!
    # If you want them to be created locally in the folders containing the source PowerPoint file, replace $curr_path with $_.DirectoryName
    $pdf_filename = "$($curr_path)\$($_.BaseName).pdf"
    # Save as PDF -- 17 is the literal value of `wdFormatPDF`
    $opt= [Microsoft.Office.Interop.Word.WdExportFormat]::wdExportFormatPDF
    $document.SaveAs($pdf_filename, $opt)
    # Close word file
    $document.Close()
}
# Exit and release the word object
$word_app.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word_app)