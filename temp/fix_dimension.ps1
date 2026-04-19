$content = Get-Content 'e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql' -Raw -Encoding UTF8
$content = $content -replace "'NORMAL'", "'categorical'"
[System.IO.File]::WriteAllText('e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql', $content, [System.Text.Encoding]::UTF8)
Write-Host "Done fixing NORMAL -> categorical"
