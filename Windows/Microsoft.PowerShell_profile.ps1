Invoke-Expression (&starship init powershell)

function export {
    # Allow setting multiple variables separated by spaces
    $args | ForEach-Object {
        $key, $value = $_ -split '=',2
        New-Item -Path Env:\$key -Value $value -Force | Out-Null
        # PowerShell seems to strip quotes by default, in case that causes unexpected behavior in the future
    }
}

function Start-PSAdmin
{
    Start-Process PowerShell -Verb RunAs
}

function Start-Proxy {
    $env:HTTP_PROXY = $env:HTTPS_PROXY = "localhost:8080"
}

function Stop-Proxy {
    Remove-Item Env:\HTTP_PROXY
    Remove-Item Env:\HTTPS_PROXY
}

Set-Alias -Name source -Value Invoke-Expression

function profile {
    code $profile
}
