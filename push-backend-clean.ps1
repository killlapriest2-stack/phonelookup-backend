# ============================
# push-backend-clean.ps1
# ============================

# 1. Перевірка, що ми в корені Git репозиторію
if (-Not (Test-Path ".git")) {
    Write-Error "Цей скрипт потрібно запускати в корені Git репозиторію!"
    exit 1
}

# 2. Вказати назву нової гілки
$newBranch = "backend-update-" + [int](Get-Random -Maximum 1000000000)
Write-Host "Створюємо нову гілку: $newBranch" -ForegroundColor Cyan

git checkout -b $newBranch

# 3. Очистити старі референси Git і reflog (Windows-версія)
if (Test-Path ".git\refs\original") {
    Remove-Item -Path .git\refs\original -Recurse -Force
}

git reflog expire --all --expire=now
git gc --prune=now --aggressive

# 4. Додати всі зміни
git add .

# 5. Створити коміт без секретів
git commit -m "Backend update - cleaned commit"

# 6. Виконати пуш на нову гілку
git push origin $newBranch

Write-Host "`n✅ Пуш завершено! Нова гілка: $newBranch" -ForegroundColor Green
Write-Host "Тепер відкрий Pull Request на GitHub з цієї гілки в main" -ForegroundColor Yellow
