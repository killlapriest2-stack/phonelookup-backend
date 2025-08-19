# push-backend-final.ps1
# ----------------------
# Push backend changes to main using PAT from environment variable

# Перевірка наявності GITHUB_TOKEN
if (-not $env:GITHUB_TOKEN) {
    Write-Error "GITHUB_TOKEN environment variable not set. Set it with setx GITHUB_TOKEN <your_token>"
    exit 1
}

$RemoteURL = "https://$($env:GITHUB_TOKEN)@github.com/killlapriest2-stack/phonelookup-backend.git"

# Додати всі зміни
git add .

# Commit із стандартним повідомленням
git commit -m "Backend update on main" 

# Встановити URL для remote
git remote set-url origin $RemoteURL

# Пуш на main
git push origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "Changes pushed successfully to main!"
} else {
    Write-Error "Push failed. Check your token and repository permissions."
}
