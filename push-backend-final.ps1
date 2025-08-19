# push-backend-final.ps1
# Push local changes to main using GITHUB_TOKEN

# Ensure GITHUB_TOKEN is set
if (-not $env:GITHUB_TOKEN) {
    Write-Error "GITHUB_TOKEN environment variable is not set. Set it and rerun the script."
    exit 1
}

# Set Git remote to use token for HTTPS
$remoteUrl = "https://$($env:GITHUB_TOKEN)@github.com/killlapriest2-stack/phonelookup-backend.git"

git remote set-url origin $remoteUrl

# Stage all changes
git add -A

# Commit changes
git commit -m "Backend update on main" -a

# Push to main
try {
    git push origin main
    Write-Host "Changes pushed successfully to main!" -ForegroundColor Green
} catch {
    Write-Error "Push failed. Check your token and repository permissions."
    exit 1
}
