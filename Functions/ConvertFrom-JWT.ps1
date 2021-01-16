function ConvertFrom-JWT {
    [CmdletBinding()]
    param (
        [Parameter(
            HelpMessage='Enter the JWT you want to convert to human readable text.'
        )]
        [string]$JWT
    )
    
    begin {
        
    }
    
    process {
        $header, $payload, $signature = $JWT.Split('.') -replace '-','+' -replace '_','/'
        $reversedJWT = [PSCustomObject]@{
            'Header' = ([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($header)) | ConvertFrom-Json)
            'Payload' = ([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($payload)) | ConvertFrom-Json)
        }
    }
    
    end {
        Write-Output -InputObject $reversedJWT
    }
}