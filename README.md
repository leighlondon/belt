# belt

A belt for handy tools.

## install

To install this from PowerShellGallery, run the following commands in PowerShell:
```powershell
Install-Module Belt -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Once it's been installed, you can import it into PowerShell with:
```powershell
Import-Module Belt
```

## profile

Belt works best when it's added to automatically load into your PowerShell session.
Add these lines to `Documents\profile.ps1`:

```powershell
Import-Module Belt
Set-Location $env:USERPROFILE
```
