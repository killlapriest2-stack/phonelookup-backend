# push-backend-final.ps1

# ---------------------------
# CONFIGURATION
# ---------------------------
$branchPrefix = "backend-update-"
$secretPatterns = @("*.env", "*.ps1") # перевіряти на ключі в цих файлах
$commitMessage = "Backend update - cleaned commit"

# ---------------------------
# CHECK GIT REPO
# ---------------------------
if (-Not (Test-Path ".git")) {
    Write-Error "This script must be run in the root of a Git repository!"
    exit 1
}

# ---------------------------
# CREATE NEW BRANCH
# ---------------------------
$newBranch = $branchPrefix + [int](Get-Random -Maximum 1000000000)
Write-Host "Creating new branch: $newBranch" -ForegroundColor Cyan
git checkout -b $newBranch

# ---------------------------
# CLEAN OLD REFERENCES AND GC
# ---------------------------
if (Test-Path ".git\refs\original") {
    Remove-Item -Path .git\refs\original -Recurse -Force
}

git reflog expire --all --expire=now
git gc --prune=now --aggressive

# ---------------------------
# CHECK FOR SECRETS
# ---------------------------
$foundSecrets = @()
foreach ($pattern in $secretPatterns) {
    $files = Get-ChildItem -Recurse -Include $pattern
    foreach ($file in $files) {
        $content = Get-Content $file -Raw
        if ($content -match "(?i)(AIza|sk-|key=|token|secret)") {
            $foundSecrets += $file.FullName
        }
    }
}

if ($foundSecrets.Count -gt 0) {
    Write-Host "ERROR: Secrets detected in the following files:" -ForegroundColor Red
    $foundSecrets | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    Write-Host "Remove secrets or add to .gitignore before pushing." -ForegroundColor Red
    exit 1
}

# ---------------------------
# STAGE AND COMMIT
# ---------------------------
git add .
git commit -m $commitMessage

# ---------------------------
# PUSH TO GITHUB
# ---------------------------
git push origin $newBranch

Write-Host "`n✅ Push completed! New branch: $newBranch" -ForegroundColor Green
Write-Host "Open a Pull Request from this branch to main on GitHub." -ForegroundColor Yellow
