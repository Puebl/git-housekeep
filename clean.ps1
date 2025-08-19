param(
    [switch]$DryRun
)

function Exec($cmd) {
    Write-Host "> $cmd"
    if (-not $DryRun) { iex $cmd }
}

# Ensure we're in a git repo
try { git rev-parse --is-inside-work-tree *> $null } catch { Write-Error "Not a git repo"; exit 1 }

Exec "git fetch --prune"

# Determine main branch
$main = "main"
if (-not (git show-ref --verify --quiet refs/heads/$main)) { $main = "master" }

# Delete merged local branches except main/master
$branches = git branch --merged $main | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "*" -and $_ -ne $main }
foreach ($b in $branches) {
    Exec "git branch -d `$b".Replace("`$b", $b)
}

# Prune remote tracking branches
Exec "git remote prune origin"

# Optional cleanup
Exec "git gc --prune=now --aggressive"

Write-Host "Done."
