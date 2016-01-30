
Add-Type -TypeDefinition @"
   public enum RestMethod
   {
      GET,
      PUT,
      POST,
      DELETE
   }
"@

Function ConvertTo-Json20 {
        [CmdletBinding()]
        Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [object]$item
        )
PROCESS {
            add-type -assembly system.web.extensions
            $ps_js=new-object system.web.script.serialization.javascriptSerializer
            return $ps_js.Serialize($item)
    }
}

Function ConvertFrom-Json20 {
        [CmdletBinding()]
        Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [object]$item
        )
PROCESS {
        add-type -assembly system.web.extensions
        $ps_js=new-object system.web.script.serialization.javascriptSerializer 
        return $ps_js.DeserializeObject($item) 
    }
}

Function Invoke-RestMethod20
{
    param
    (
        [Parameter(Mandatory)]
        [RestMethod]
        $Method,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Uri,
        [Parameter(Mandatory=$false)]
        [object]
        $Body,
        [Parameter(Mandatory=$false)]
        [System.string]
        $User,
        [Parameter(Mandatory=$false)]
        [System.String]
        $Password,
        [Parameter(Mandatory=$false)]
        [System.String]
        $UserAgent,
        [Parameter(Mandatory=$false)]
        [switch]
        $asJson,
        [System.String]
        $ContentType = 'application/json',
        [Parameter(Mandatory=$false)]
        [object]
        $Headers
    )
    $webclient = New-Object System.Net.WebClient
    $webclient.Headers.add("ContentType", $ContentType)

    ##Extra Headers
    if ($Headers -ne $null)
    {
        $webclient.Headers.Add($Headers)
    }

    ##Autentication
    if ($user -ne $null -and $Password -ne $null)
    {
        $creds = New-Object System.Net.NetworkCredential($User,$Password);
        $webclient.Credentials = $creds
    }

    ##User Agent
    if ($UserAgent -ne $null)
    {
        $webclient.Headers.Add("user-agent", $UserAgent)
    }

    ##Get Response
    Try 
    {
        if ($Method -eq "GET")
        {
            $response = $webClient.DownloadString($Uri)
        }
        elseif ($Method -eq "PUT" -or $Method -eq "POST")
        {
            $response = $webClient.UploadString($Uri,$Method,$Body)
        }
    }

    Catch
    {
        Write-host $_.Exception
    }

    ##Return Response
    if ($asJson)
    {
        return $response
    }
    return $response | ConvertFrom-Json20Pipe
}
