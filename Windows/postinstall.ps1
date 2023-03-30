Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PowerShellGet -Force

# TODO: fails until new shell started thanks to PowerShellGet upgrade
Install-Module PSReadLine -AllowPrerelease -Force
