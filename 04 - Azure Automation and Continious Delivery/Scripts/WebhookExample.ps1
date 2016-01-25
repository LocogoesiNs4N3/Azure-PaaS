# Variables to Set
$WebhookURI = "https://s2events.azure-automation.net/webhooks?token=TPna6sUVX7y8V2BGA6kgeEh8uYrL0cVer9MIX7lM2GI%3d"
$VMName = "ContosoVM01"

# Static Variables
$headers = @{"AuthorizationValue"="Contoso"}
$WebhookBody  = @([pscustomobject]@{VMName=$VMName})

# Convert to JSON format
$body = ConvertTo-Json `
        -InputObject $WebhookBody

# Execute HTTP request
$response = Invoke-WebRequest `
            -Method Post `
            -Uri $WebhookURI `
            -Headers $headers `
            -Body $body

# Show response
$response 

#Get Job ID
$jobid = (ConvertFrom-Json ($response.Content)).jobids[0]

# Show Job ID information
$jobid 