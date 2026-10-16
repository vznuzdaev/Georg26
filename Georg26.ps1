$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$root      = Split-Path -Parent $scriptDir

$src = Join-Path $root "Georg26_tmp"
$dst = $scriptDir

if (-not (Test-Path $src)) {
    Write-Error "Не найдена папка-источник: $src"
    exit 1
}

# 1. Копируем всё содержимое из Georg26_tmp в Georg26
Copy-Item -Path "$src\*" -Destination $dst -Recurse -Force

# 2. index.html = свежий messages.html
Copy-Item -Path "$src\messages.html" -Destination "$dst\index.html" -Force

# 3. Git — работаем прямо из папки репозитория (Georg26)
Set-Location $dst
git add .
git commit -m "Автообновление $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push