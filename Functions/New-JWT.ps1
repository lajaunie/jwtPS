function New-JWT {
    [CmdletBinding()]
    param (
        [Parameter(
            HelpMessage='The private key to sign the JWT.'
        )]
        [string]$PrivateKey,
        
        [Parameter(
            HelpMessage='Setting the encryption algorithm.'
        )]
        [Algorithm]$Algorithm = [Algorithm]::new(),

        [Parameter(
            HelpMessage='Provide the payload for the JWT'
        )]
        [Hashtable]$Payload
    )
    
    begin {
        
    }
    
    process {
        $header = [jwtHeader]::new()
        $header.Algorithm = $Algorithm
        $claimSet = [jwtClaimSet]::new()
        $signature = [jwtSignature]::new($PrivateKey, "$($header.Create()).$($claimSet.Create($Payload))", $Algorithm)
    }
    
    end {
        Write-Output -InputObject ($signature.Create() -replace '\+','-' -replace '/','_' -replace '=')
    }
}