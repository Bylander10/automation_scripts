function Get-List {
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

$randomSuffix = Get-Random -Minimum 0 -Maximum 1001
$nameBaseFolder = "testing$randomSuffix"
$basePath = Join-Path -Path $env:USERPROFILE - ChildPath "Documents\$nameBaseFolder"

try {
    New-Item -Path $basePath -ItemType Directory -Force -ErrorAction Stop
    Write-Host "Root folder created: $basePath" -ForegroundColor Green
} catch {
    Write-HOst "Error while creating root folder: $_" -ForegroundColor Red
    exit
}

Write-Host "`nInsert professors list:" -ForegroundColor Blue
$professors = Get-List

Write-Host "`nInsert subjects list:" -ForegroundColor Blue
$subjects = Get-List

if ($professors.Count -ne $subjects.Count) {
    Write-Host "Error: number of professors and subjects doesn't match." -ForegroundColor Red
    exit
}

$professorsSubjects = @{}

for ($i = 0; $i -lt $professors.Count; $i++) {
    $professor = "Professor " + (Sanitize-Path -name ($professors[$i] -replace '\s+', ' '))
    $subject = Sanitize-Path -name $subjects[$i]

    if (-not $professorsSubjects.ContainsKey($professor)) {
        $professorsSubjects[$professor] = @()
    }
    $professorsSubjects[$professor] += $subject
}

foreach ($professor in $professorsSubjects.Keys) {
    $professorPath = Join-Path -Path $basePath -ChildPath $professor
    try {
        New-Item -Path $professorPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        foreach ($subject in $professorsSubjects[$professor]) {
            $subjectPath = Join-Path -Path $professorPath -ChildPath $subject
            New-Item -Path $subjectPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
        }
    } catch {
        Write-Host "Error while creating folder for $professor : $_" -ForegroundColor Red
    }
}

Write-Host "`nDone! :3 Structure created in:`n$basePath" -ForegroundColor Cyan

