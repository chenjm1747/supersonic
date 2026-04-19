# 读取UTF-8编码的SQL文件并执行
$sqlContent = Get-Content -Path "e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql" -Encoding UTF8 -Raw

# 创建临时文件
$tempFile = "e:\trae\supersonic\temp\supersonic_semantic_model_insert_utf8.sql"
$sqlContent | Out-File -FilePath $tempFile -Encoding UTF8

# 执行SQL
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -f $tempFile

# 删除临时文件
Remove-Item $tempFile -Force
