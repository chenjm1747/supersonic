$content = Get-Content 'e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql' -Raw -Encoding UTF8

$replacements = @{
    ", '组织类型'" = ", '[\"类型\"]'"
    ", '面积ID'" = ", '[\"面积标识\"]'"
    ", '面积类别'" = ", '[\"类别\"]'"
    ", '单价类别:居民/非居民/困难户等'" = ", '[\"单价类别\"]'"
    ", '结算方式'" = ", '[\"结算方式\"]'"
    ", '供暖状态'" = ", '[\"状态\"]'"
    ", '阀门状态'" = ", '[\"阀门\"]'"
    ", '日期ID'" = ", '[\"日期\"]'"
    ", '年份'" = ", '[\"年\"]'"
    ", '月份'" = ", '[\"月\"]'"
    ", '季度'" = ", '[\"季度\"]'"
    ", '采暖期年份'" = ", '[\"采暖年\"]'"
    ", '采暖期月份'" = ", '[\"采暖月\"]'"
    ", '缴费季标识'" = ", '[\"缴费季\"]'"
    ", '费用类别'" = ", '[\"费用类别\"]'"
    ", 'event'" = ", '[\"事件\"]'"
    ", '收费日期'" = ", '[\"收费时间\"]'"
    ", '收费方式'" = ", '[\"支付方式\"]'"
    ", '支付渠道'" = ", '[\"渠道\"]'"
    ", '发票类别'" = ", '[\"发票\"]'"
    ", '统计月份'" = ", '[\"月份\"]'"
    ", '统计日期'" = ", '[\"日期\"]'"
    ", '欠费等级'" = ", '[\"欠费等级\"]'"
}

foreach ($key in $replacements.Keys) {
    $content = $content -replace [regex]::Escape($key), $replacements[$key]
}

[System.IO.File]::WriteAllText('e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql', $content, [System.Text.Encoding]::UTF8)
Write-Host "Done fixing remaining alias fields"
