# Invoke-RestMethod-2.0

Rest client for powershell 2.0 and above

Example:

####GET
```powershell
Invoke-RestMethod20 -Method GET -Uri "http://httpbin.org/ip"
```
####POST
```powershell
$body = @{Data = "some post data"} | ConvertTo-Json20
Invoke-RestMethod20 -Method POST -Uri "http://httpbin.org/post" -Body $body
```
####PUT
```powershell
$body = @{User = "username"; Password = "password"} | ConvertTo-Json20  
Invoke-RestMethod20 -Method PUT -Uri "http://httpbin.org/put" -Body $body -asJson
```
