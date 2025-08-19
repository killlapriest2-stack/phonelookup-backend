# push-backend-final.ps1

# Перевірка наявності GITHUB_TOKEN
if (-not $env:GITHUB_TOKEN) {
    Write-Host "Error: GITHUB_TOKEN environment variable is not set." -ForegroundColor Red
    exit 1
}

# Встановимо remote з використанням токена
$repoUrl = "https://$($env:GITHUB_TOKEN)@github.com/killlapriest2-stack/phonelookup-backend.git"

# Ініціалізація Git у поточній папці (якщо потрібно)
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $repoUrl
} else {
    git remote set-url origin $repoUrl
}

# Додаємо всі зміни
git add .

# Коміт
git commit -m "Backend update on main" 

# Пуш на main
git push origin main --force

Write-Host "Changes pushed successfully to main!" -ForegroundColor Green
