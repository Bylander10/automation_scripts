function Get-Lista {
    Write-Host "Paste the items list(1 per line)(press Enter twice):" -ForegroundColor DarkGray
    $list = @()
    while ($true) {
        $item = Read-Host
        if ([String]::IsNullOrWhiteSpace($item)) {break}
        $list += $item.Trim()
    }
    return $lista
}

function Sanitize-Path {
    param ([String]$name)
    $invalidChars [IO.Path]::GetInvalidFileNameChars() -join ''
    return ($name -replace "[$invalidChars]", " -").Trim()
}

