# Invoke-RestMethod-2.0

Rest client for powershell 2.0 and above

Example:

####GET
Invoke-RestMEthod20 -Method GET -Uri "http://httpbin.org/ip"

####POST
$body = @{Data = "some post data"} | ConvertTo-Json20<br />
Invoke-RestMEthod20 -Method POST -Uri "http://httpbin.org/post" -Body $body

####PUT
$body = @{User = "username"; Password = "password"} | ConvertTo-Json20 <br /> 
Invoke-RestMEthod20 -Method PUT -Uri "http://httpbin.org/put" -Body $body -asJson
