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
    "MSTeams"
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

Remove-Item "$([Environment]::GetFolderPath('Desktop'))\*.lnk"
Remove-Item "$env:PUBLIC\Desktop\*.lnk"

# CaskaydiaMono Nerd Font
$temp = Join-Path $([System.IO.Path]::GetTempPath()) "CascadiaMono-$([System.IO.Path]::GetRandomFileName())"
New-Item -ItemType Directory -Path $temp
$zip = "$temp\CascadiaMono.zip"
Invoke-WebRequest -Uri https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip -OutFile $zip
Expand-Archive -Path $zip -DestinationPath $temp
# https://www.alkanesolutions.co.uk/2021/12/06/installing-fonts-with-powershell/
$fontNamespace = (New-Object -ComObject Shell.Application).Namespace(0x14)
Get-ChildItem -Path "$temp\*.ttf" | ForEach-Object { $fontNamespace.CopyHere($_.FullName,0x14) }
Remove-Item -Path $temp -Recurse

# Force display all tray icons (at the time of execution)
Get-ChildItem -Path 'HKCU:\Control Panel\NotifyIconSettings\' | ForEach-Object { Set-ItemProperty -Path "HKCU:\$($_.Name)" -Name IsPromoted -Value 1 }

# Snipping Tool's most annoying setting
# https://www.damirscorner.com/blog/posts/20150117-ManipulatingSettingsDatFileWithSettingsFromWindowsStoreApps.html
reg load HKLM\_Settings $env:LOCALAPPDATA\Packages\Microsoft.ScreenSketch_8wekyb3d8bbwe\Settings\settings.dat
reg import HKLM\_Settings "Snipping Tool.reg"
reg unload HKLM\_Settings

# Edit Chrome settings (probably a bad idea)
$prefsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Preferences"
$preferences = Get-Content $prefsPath -Encoding UTF8 | ConvertFrom-Json
$preferences.bookmark_bar.show_tab_groups = $false
$preferences.devtools.preferences.currentDockState = "undocked"
$preferences.devtools.synced_preferences_sync_disabled["disable-self-xss-warning"] = $true
$preferences.download.default_directory = "$env:USERPROFILE\Desktop"
$preferences.download.prompt_for_download = $true
$preferences.omnibox.prevent_url_elisions = $true
$preferences.omnibox.show_google_lens_shortcut = $false
$preferences.savefile = "$env:USERPROFILE\Desktop"
ConvertTo-Json $preferences -Compress -Depth 100 | Out-File $prefsPath -Encoding UTF8
$statePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"
$localstate = Get-Content $statePath -Encoding UTF8 | ConvertFrom-Json
# Scroll tabs instead of sending them into the shadow realm for some reason
$localstate.browser.enabled_labs_experiments += "scrollable-tabstrip@2"
$localstate.browser.enabled_labs_experiments += "top-chrome-toasts@6"
$localstate.browser.hovercard.memory_usage_enabled = $false
$localstate.settings.a11y.overscroll_history_navigation = $false
$localstate.settings.toast.alert_level = 1 # Disable copy URL toast messages designed by morons for morons
ConvertTo-Json $localstate -Compress -Depth 100 | Out-File $statePath -Encoding UTF8

# Nuke Chrome extensions installed by other apps
Remove-Item -Path HKCU:\SOFTWARE\Google\Chrome\Extensions -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Google\Chrome\Extensions -Recurse

# Copy Spotify settings
$spotifyProfile = @("$env:APPDATA\Spotify", "$env:LOCALAPPDATA\Packages\SpotifyAB.SpotifyMusic_zpdnekdrzrea0\LocalState\Spotify") |
    ForEach-Object {
        Get-ChildItem "$_\Users" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Fullname -First 1
    } | Where-Object { $_ } | Select-Object -First 1
if ($spotifyProfile) {
    Copy-Item ../spotify.properties "$spotifyProfile\prefs"
}
