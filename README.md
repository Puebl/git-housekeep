# PowerShell Git Housekeep

Cleans merged local branches, prunes remotes, and optionally does a dry run.

## Run
```
cd powershell_git_housekeep
powershell -ExecutionPolicy Bypass -File clean.ps1 -DryRun:$true
```
Then run without `-DryRun`.
