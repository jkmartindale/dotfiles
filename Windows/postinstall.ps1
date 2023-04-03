Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PowerShellGet -Force

# TODO: fails until new shell started thanks to PowerShellGet upgrade
Install-Module PSReadLine -AllowPrerelease -Force

New-Item -ItemType HardLink -Path "C:\Users\JamesMartindale\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ubuntu.png" -Value "C:\Users\JamesMartindale\Repositories\dotfiles\Windows\windows-terminal\ubuntu.png"

New-Item -ItemType HardLink -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ubuntu.png" -Value "$env:USERPROFILE\Repositories\dotfiles\Windows\windows-terminal\ubuntu.png"
