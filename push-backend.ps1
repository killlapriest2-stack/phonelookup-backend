# push-backend.ps1 — пуш у нову гілку без обмежень

# якщо git ще не ініціалізовано
if (-not (Test-Path ".git")) {
    git init
    git remote add origin git@github.com:killlapriest2-stack/phonelookup-backend.git
}

# додаємо всі зміни
git add .

# створюємо коміт (навіть якщо нічого немає — allow-empty)
git commit -m "Backend update" --allow-empty

# генеруємо унікальну назву гілки
$branchName = "backend-update-" + (Get-Random)

# створюємо нову гілку
git checkout -b $branchName

# пушимо у віддалений репозиторій
git push origin $branchName --force

Write-Host "✅ Зміни успішно запушені у гілку $branchName" -ForegroundColor Green
Write-Host "👉 Тепер створи Pull Request у GitHub, щоб злити у main"
