# Load .env
$envFile = ".env"
if (-Not (Test-Path $envFile)) {
    Write-Host ".env file not found!" -ForegroundColor Red
    exit 1
}

Get-Content $envFile | ForEach-Object {
    if ($_ -match "^\s*([^#=]+)=(.*)$") {
        $name  = $matches[1].Trim()
        $value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($name, $value, "Process")
    }
}

$GitHubUser = $env:GITHUB_USER
$GitHubPAT  = $env:GITHUB_PAT
$RepoName   = $env:GITHUB_REPO

if (-not $GitHubUser -or -not $GitHubPAT -or -not $RepoName) {
    Write-Host "Check .env values: GITHUB_USER, GITHUB_PAT, GITHUB_REPO" -ForegroundColor Red
    exit 1
}

# Init repo if not exists
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Git repository initialized."
} else {
    Write-Host "Git repository already exists."
}

# Add remote (replace if exists)
git remote remove origin 2>$null
git remote add origin "https://$GitHubUser`:$GitHubPAT@github.com/$GitHubUser/$RepoName.git"
Write-Host "Remote origin added with token."

# Stage & commit
git add .
git commit -m "Auto commit from PowerShell script"
Write-Host "Files committed."

# Push
git push -u origin main
Write-Host "All files pushed to GitHub!" -ForegroundColor Green
