# =============================
# push-backend-final.ps1
# =============================

# Check if GITHUB_TOKEN is set
if (-not $env:GITHUB_TOKEN) {
    Write-Host "ERROR: GITHUB_TOKEN is not set" -ForegroundColor Red
    exit 1
}

# Ensure we are on main branch
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne "main") {
    Write-Host "Switching to main branch..."
    git checkout main
}

# Stage all changes
git add .

# Commit changes
git commit -m "Backend update on main"

# GitHub repository URL
$repoURL = "https://github.com/killlapriest2-stack/phonelookup-backend.git"

# Use token in HTTPS for authentication
$secureURL = $repoURL -replace "https://", "https://$($env:GITHUB_TOKEN)@"

# Push to main
git push $secureURL main

Write-Host "✅ Changes pushed successfully to main!" -ForegroundColor Green
