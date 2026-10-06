# Batch rename all PNG files in each subfolder to 1.png, 2.png ...
# Uses natural numeric sorting to avoid 1, 10, 2 order issues.

$root = "D:\Vibecoding\a3\assets\player"

if (-not (Test-Path $root)) {
    Write-Host "ERROR: root folder not found -> $root" -ForegroundColor Red
    exit
}

$subFolders = Get-ChildItem -Path $root -Directory

if ($subFolders.Count -eq 0) {
    Write-Host "No subfolders found." -ForegroundColor Yellow
    exit
}

Write-Host "Found $($subFolders.Count) folder(s), processing..." -ForegroundColor Cyan

foreach ($folder in $subFolders) {
    Write-Host ""
    Write-Host ">>> Processing: $($folder.Name)" -ForegroundColor Magenta

    # Natural numeric sort: extract digits from filename and sort by integer value
    $files = Get-ChildItem -Path $folder.FullName -Filter *.png |
        Sort-Object { [int]($_.BaseName -replace '\D','') }

    if ($files.Count -eq 0) {
        Write-Host "    No PNG files, skip." -ForegroundColor Yellow
        continue
    }

    $tempNames = @()
    $i = 1
    foreach ($file in $files) {
        $tempName = "__temp_$i.png"
        Rename-Item -Path $file.FullName -NewName $tempName
        $tempNames += [PSCustomObject]@{
            OldPath = Join-Path $folder.FullName $tempName
            NewName = "$i.png"
        }
        $i++
    }

    foreach ($item in $tempNames) {
        Rename-Item -Path $item.OldPath -NewName $item.NewName
    }

    Write-Host "    Done, renamed $($files.Count) file(s)." -ForegroundColor Green
}

Write-Host ""
Write-Host "All done!" -ForegroundColor Cyan