Add-Type -AssemblyName System.Windows.Forms

function Send-Keys {
    param ([string]$keys)
    [System.Windows.Forms.SendKeys]::SendWait($keys)
    Start-Sleep -Milliseconds 400
}

$line = Read-Host "Type the number of Excel line"

$coumns = @("B", "C", "M", "Q", "E")
$termoBusca = @("[name]", "[ra]", "[group]", "[week]", "[subject]")

Send-Keys "^1"
Start-Sleep -Seconds 4

for ($i = 0; $i -lt $columns.Length; $i++) {
    Send-Keys "^j"
    Send-Keys "$($columns[$i])$line{ENTER}"
    Send-Keys "^a^c"
    Start-Sleep -Milliseconds 300

    if ($i -eq 3) {
        $originalText = [System.Windows.Forms.Clipboard]::GetText()
        $modifiedText = $originalText.ToUpper() + "S"
        [System.Windows.Forms.Clipboard]::SetText($modifiedText)
    }

    Send-Keys "^2"
    Start-Sleep -Milliseconds 500

    Send-Keys "^f"
    Send-Keys "$($searchTerm[$i]){ENTER}"
    Send-Keys "{ESC}"
    Send-Keys "^v"
    if ($i -eq 3) {
        Send-Keys "{LEFT}"
        Send-Keys "{BS}"
    }
    else {
        Send-Keys "{DEL}"
    }
    Start-Sleep -Milliseconds 500

    Send-Keys "^1"
    Start-Sleep -Milliseconds 800
}

Send-Keys "^j"
Send-Keys "H16{ENTER}"
Start-Sleep -Milliseconds 800

Write-Host "Task done!" -ForegroundColor Green
Write-Host " "
Write-Host "E-mail generated success! :3"
Write-Host " "

