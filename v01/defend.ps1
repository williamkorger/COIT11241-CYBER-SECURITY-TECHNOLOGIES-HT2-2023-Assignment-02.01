# defend.ps1

function testInternetAccess {
    try {
        $response = Invoke-WebRequest -Uri "http://www.example.com" -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-Host "Internet access is working."
        } else {
            Write-Host "Internet access is not working."
        }
    } catch {
        Write-Host "Internet access is not working."
    }
}
function enableRestrictInternet {
    [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("http://proxy", $true)
    Write-Host "Internet access restricted."
}

function resetRestrictInternet {
    [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null)
    Write-Host "Internet access is now enabled."
}

# Check command line argument
if ($args.Length -gt 0) {
    $arg = $args[0].ToLower()
    switch ($arg) {
        "testinternetaccess" { testInternetAccess }
        "enablerestrictinternet" { enableRestrictInternet }
        "resetrestrictinternet" { resetRestrictInternet }
        default { Write-Host "Invalid argument. Use 'testInternetAccess', 'enableRestrictInternet', or 'resetRestrictInternet'." }
    }
} else {
    Write-Host "No argument provided. Use 'testInternetAccess', 'enableRestrictInternet', or 'resetRestrictInternet'."
}
