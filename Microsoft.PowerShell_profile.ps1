# might need global:Get-UriHash
function Get-UrlHash
{
    <#
    .Synopsis

    Computes the hash value for a file reachable from a URL by using a specified hash algorithm.

    .Description

    The `Get-UrlHash` cmdlet computes the hash value for a file reachable from a URL by using a specified hash algorithm. A hash value is a unique value that corresponds to the content of the file. Rather than identifying the contents of a file by its file name, extension, or other designation, a hash assigns a unique value to the contents of a file. File names and extensions can be changed without altering the content of the file, and without changing the hash value. Similarly, the file's content can be changed without changing the name or extension. However, changing even a single character in the contents of a file changes the hash value of the file.

    For more information on file hashing, see Get-FileHash.

    .Parameter Urls

    Specifies the path to one or more file URLs as an array.

    .Parameter Algorithm

    Specifies the cryptographic hash function to use for computing the hash value of the contents of the specified
    file or stream. A cryptographic hash function has the property that it is infeasible to find two different
    files with the same hash value. Hash functions are commonly used with digital signatures and for data
    integrity. The acceptable values for this parameter are:

    - SHA1

    - SHA256

    - SHA384

    - SHA512

    - MACTripleDES

    - MD5

    - RIPEMD160

    If no value is specified, or if the parameter is omitted, the default value is SHA256.
    For security reasons, MD5 and SHA1, which are no longer considered secure, should only be used for simple
    change validation, and should not be used to generate hash values for files that require protection from
    attack or tampering.

    .Example Compute the hash value for a file pointed to by a URL

    Get-UrlHash https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash | Format-List

    Algorithm : SHA256
    Hash      : 4C96F1D1AC0ED8B017F299C8C15A21B097314DEBF9166EAE18B6B09BEF6D99B1

    .Example Compute the MD5 hash value for a file pointed to by a URL

    Get-UrlHash https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash MD5 | Format-List

    Algorithm : MD5
    Hash      : BFEB321F87DAD47CBF3A16190DF21CC2

    .Inputs
    
    System.Uri[]
        You can pipe a list of file URLs to the `Get-UrlHash` function.
    
    .Outputs

    PSCustomObject
        An object with an Algorithm property and a Hash property.

        `Get-UrlHash` doesn't output a Microsoft.Powershell.Utility.FileHash because doing so would force display of the empty `Path` property in Write-Output etc.

    .Link

    Get-FileHash
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
        HelpMessage="Enter a URL referencing the file to calculate a hash for.",
        Position=0,
        ValueFromPipeline=$true)]
        [System.Uri[]] $Urls,

        [Parameter(Position=1)]
        [String] $Algorithm='SHA256'
    )
    Begin
    {
        $client = [System.Net.WebClient]::new()
    }
    Process
    {
        ForEach ($Url in $Urls) {
            $HashObject = Get-FileHash -InputStream ($client.OpenRead($Url)) -Algorithm $Algorithm
            [PSCustomObject] @{
                Algorithm = $HashObject.Algorithm
                Hash = $HashObject.Hash
            }
        }
    }
}

function Start-PSAdmin
{
    Start-Process PowerShell -Verb RunAs
}