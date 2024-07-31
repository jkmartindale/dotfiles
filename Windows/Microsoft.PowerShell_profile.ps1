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
    steam-idle.exe ($args -replace "[^\d]*")
}
