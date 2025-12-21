Invoke-Expression (&starship init powershell)
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardKillWord
# https://devblogs.microsoft.com/powershell/outputencoding-to-the-rescue/
$outputencoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

$env:PATH = (($env:PATH.Split(';') | Where-Object { $_ -ne "C:\WINDOWS\system32" }) -join ';') + ";C:\WINDOWS\system32"

# Supports a workflow to check my online accounts every 300 days
function 1pcheck {
    $user_id = (op user list --format json | ConvertFrom-JSON)[0].id
    $items = (op item list --long --format json | ConvertFrom-Json)
    $items | Where-Object { $_.last_edited_by -eq $user_id -and ($_.category | Select-String -NotMatch CREDIT_CARD,DOCUMENT,MEMBERSHIP,PASSPORT,PASSWORD,SECURE_NOTE,SERVER,SOFTWARE_LICENSE,WIRELESS_ROUTER) } | Sort-Object -Property updated_at | Select-Object -First ([math]::ceiling($items.Length / 300)) -Property title, @{Name='username'; Expression='additional_information'}
}

function ConvertFrom-MIME { $args | python -c "__import__('quopri').decode(__import__('sys').stdin.buffer, __import__('sys').stdout.buffer)" }

Remove-Item alias:curl
$PSDefaultParameterValues["Invoke-WebRequest:UseBasicParsing"] = $true

function export {
    # Allow setting multiple variables separated by spaces
    $args | ForEach-Object {
        $key, $value = $_ -split '=',2
        New-Item -Path Env:\$key -Value $value -Force | Out-Null
        # PowerShell seems to strip quotes by default, in case that causes unexpected behavior in the future
    }
}

function Get-FreeGamesPromotions {
    (Invoke-RestMethod "https://store-site-backend-static-ipv4.ak.epicgames.com/freeGamesPromotions?locale=en-US&country=US&allowCountries=US").data.Catalog.searchStore.elements |
    Where-Object { $null -ne $_.promotions -and $_.promotions.upcomingPromotionalOffers.Count -gt 0 } |
    Select-Object -Property title,{$_.productSlug}
}

Set-Alias intellij idea64

function profile {
    code $profile
}

function Start-Proxy {
    $env:HTTP_PROXY = $env:HTTPS_PROXY = "localhost:8080"
}

function Stop-Proxy {
    Remove-Item Env:\HTTP_PROXY
    Remove-Item Env:\HTTPS_PROXY
}

Set-Alias -Name source -Value Invoke-Expression

function steam-idle {
    # steam-idle.exe from https://github.com/JonasNilson/idle_master_extended
    if ($args.Length -lt 1) {
        return Write-Error "Please provide an appid."
    }
    $app = $args[0] -replace "[^\d]*" # so I can paste steam:/// URIs without trimming
    if ($args.Length -ge 2) {
        $minutes = $args[1]
        return Start-Process powershell.exe -WindowStyle hidden -ArgumentList (
            '-Command "$process = Start-Process steam-idle.exe -ArgumentList ' + $app +
            ' -PassThru; Start-Sleep -Seconds ' + $minutes * 60 +
            '; Stop-Process $process"')
    }
    return steam-idle.exe $app
}

