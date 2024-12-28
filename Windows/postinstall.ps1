Set-ExecutionPolicy -ExecutionPolicy RemoteSigned # Not helpful rn but it's here as a reminder

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PowerShellGet -Force
# TODO: fails until new shell started thanks to PowerShellGet upgrade
Install-Module PSReadLine -AllowPrerelease -Force

# Never sleep when plugged in
powercfg /CHANGE standby-timeout-ac 0
# Turn on battery saver at 10%
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_ENERGYSAVER ESBATTTHRESHOLD 10

# Enable cursor shadow (won't take effect until after restart)
# https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc957204(v=technet.10)
$mask = [byte[]](Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask").UserPreferencesMask
$mask[1] = $mask[1] -bor 0x20
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value $mask

# Receive updates for other Microsoft products
(New-Object -ComObject Microsoft.Update.ServiceManager).AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "")

@(
    "Clipchamp.Clipchamp"
    "Microsoft.549981C3F5F10" # Cortana
    "Microsoft.6365217CE6EB4" # Microsoft Defender
    "Microsoft.BingNews"
    "Microsoft.Copilot"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftJournal"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.People"
    "Microsoft.Todos"
    "Microsoft.Whiteboard"
    "Microsoft.Windows.DevHome"
    "microsoft.windowscommunicationsapps" # Mail and Calendar
    "Microsoft.WindowsMaps"
    "MicrosoftCorporationII.MicrosoftFamily"
    "MicrosoftTeams"
) | ForEach-Object { Get-AppxPackage $_ | Remove-AppxPackage }

Add-WindowsCapability -Online -Name (Get-WindowsCapability -Online -Name "App.WirelessDisplay.Connect*").Name
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

New-Item -ItemType HardLink -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ubuntu.png" -Value "$env:USERPROFILE\Repositories\dotfiles\Windows\windows-terminal\ubuntu.png"
wsl --install -d Ubuntu

Set-Service -Name "ssh-agent" -StartupType "Automatic"

Move-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\7-Zip\7-Zip File Manager.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"
Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\7-Zip" -Recurse

$config = "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\Config\Windows\GameUserSettings.ini"
(Get-Content $config) -replace '(MinimiseToSystemTray|NotificationsEnabled_FreeGame|NotificationsEnabled_Adverts)=True', '$1=False' | Set-Content $config
$path = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Epic Games Store"
if (-not (Test-Path $path)) {
    New-Item -Path $path -ItemType Directory
}
@"
[InternetShortcut]
IconIndex=0
URL=com.epicgames.launcher://apps/0584d2013f0149a791e7b9bad0eec102%3A6e563a2c0f5f46e3b4e88b5f4ed50cca%3A9d2d0eb64d5c44529cece33fe2a46482?action=launch&silent=true
IconFile=C:\Program Files\Epic Games\GTAV\PlayGTAV.exe
"@ | Set-Content -Path "$path\Grand Theft Auto V.url"
Move-Item -Path "$path\..\Epic Games Launcher.lnk" -Destination $path
